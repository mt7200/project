#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const https = require('https');
const http = require('http');

const CONFIG_FILE = path.join(__dirname, '.workflow-config.json');

function loadConfig() {
  if (fs.existsSync(CONFIG_FILE)) {
    const config = JSON.parse(fs.readFileSync(CONFIG_FILE, 'utf8'));
    return config;
  }
  
  return {
    serverUrl: `http://${process.env.HEARKEN_PM_HOST_IP || 'localhost'}:${process.env.HEARKEN_PM_HOST_WEB_PORT || '8585'}`,
    apiKey: process.env.WORKFLOW_API_KEY || 'your-api-key-here',
    timeout: parseInt(process.env.WORKFLOW_TIMEOUT) || 30000
  };
}

function validateWorkflow(workflow) {
  if (!workflow.uniquekey || !workflow.name) {
    throw new Error('Invalid workflow: missing required fields (uniquekey, name)');
  }

  if (!workflow.nodes || Object.keys(workflow.nodes).length === 0) {
    throw new Error('Invalid workflow: no nodes defined');
  }

  if (!workflow.lines || Object.keys(workflow.lines).length === 0) {
    throw new Error('Invalid workflow: no lines defined');
  }

  const nodeKeys = new Set(Object.keys(workflow.nodes));
  
  for (const lineKey in workflow.lines) {
    const line = workflow.lines[lineKey];
    if (!nodeKeys.has(line.from) || !nodeKeys.has(line.to)) {
      throw new Error(`Invalid workflow: line references non-existent node (${line.from} -> ${line.to})`);
    }
    
    if (line.lp) {
      const [x, y] = line.lp.split(',').map(s => parseFloat(s.trim()));
      if (isNaN(x) || isNaN(y)) {
        throw new Error(`Invalid workflow: line ${lineKey} has invalid lp coordinates`);
      }
    }
  }

  const startNodes = Object.values(workflow.nodes).filter(node => node.type === 'start');
  const endNodes = Object.values(workflow.nodes).filter(node => node.type === 'end');

  if (startNodes.length !== 1) {
    throw new Error('Invalid workflow: must have exactly one start node');
  }

  if (endNodes.length !== 1) {
    throw new Error('Invalid workflow: must have exactly one end node');
  }

  for (const nodeKey in workflow.nodes) {
    const node = workflow.nodes[nodeKey];
    if (typeof node.left !== 'number' || typeof node.top !== 'number' ||
        typeof node.width !== 'number' || typeof node.height !== 'number') {
      throw new Error(`Invalid workflow: node ${nodeKey} missing required position/size properties`);
    }
  }

  return true;
}

function publishWorkflow(workflowFile, config) {
  return new Promise((resolve, reject) => {
    const workflow = JSON.parse(fs.readFileSync(workflowFile, 'utf8'));
    
    console.log(`Validating workflow: ${workflow.uniquekey}`);
    validateWorkflow(workflow);
    console.log('✓ Workflow is valid');

    const baseUrl = config.serverUrl.replace(/\/$/, '');
    const apiPath = '/das-pm/pm/definition';
    const url = new URL(`${baseUrl}${apiPath}`);
    const isHttps = url.protocol === 'https:';
    const client = isHttps ? https : http;

    const requestBody = {
      uniquekey: workflow.uniquekey,
      name: workflow.name,
      description: workflow.description || '',
      version: workflow.version || '1',
      code: workflow.code || '',
      type: workflow.type || '',
      content: JSON.stringify(workflow),
      state: workflow.state !== undefined ? workflow.state : 1,
      params: workflow.params || {}
    };

    const options = {
      hostname: url.hostname,
      port: url.port || (isHttps ? 443 : 80),
      path: url.pathname,
      method: 'POST',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': `Bearer ${config.apiKey}`
      }
    };

    console.log(`Publishing workflow to: ${baseUrl}${apiPath}`);
    console.log(`Method: ${options.method}`);
    console.log(`Unique Key: ${workflow.uniquekey}`);

    const req = client.request(options, (res) => {
      let data = '';

      res.on('data', (chunk) => {
        data += chunk;
      });

      res.on('end', () => {
        if (res.statusCode >= 200 && res.statusCode < 300) {
          console.log('✓ Workflow published successfully!');
          const responseData = JSON.parse(data);
          console.log('Response:', JSON.stringify(responseData, null, 2));
          
          const workflowId = responseData.data || responseData.id;
          
          if (workflowId && workflowFile.endsWith('.fix')) {
            try {
              const workflowData = JSON.parse(fs.readFileSync(workflowFile, 'utf8'));
              workflowData.id = workflowId;
              fs.writeFileSync(workflowFile, JSON.stringify(workflowData, null, 2), 'utf8');
              console.log(`✓ Updated workflow file with ID: ${workflowId}`);
            } catch (error) {
              console.warn('⚠ Warning: Failed to update workflow file with ID:', error.message);
            }
          }
          
          resolve(responseData);
        } else {
          console.error(`✗ Failed to publish workflow: ${res.statusCode}`);
          console.error('Response:', data);
          reject(new Error(`HTTP ${res.statusCode}: ${res.statusMessage}`));
        }
      });
    });

    req.on('error', (error) => {
      console.error('✗ Error publishing workflow:', error.message);
      reject(error);
    });

    req.setTimeout(config.timeout, () => {
      req.destroy();
      reject(new Error(`Request timeout after ${config.timeout}ms`));
    });

    req.write(JSON.stringify(requestBody));
    req.end();
  });
}

function updateWorkflow(workflowFile, config) {
  return new Promise((resolve, reject) => {
    const workflow = JSON.parse(fs.readFileSync(workflowFile, 'utf8'));
    
    console.log(`Validating workflow: ${workflow.uniquekey}`);
    validateWorkflow(workflow);
    console.log('✓ Workflow is valid');

    const baseUrl = config.serverUrl.replace(/\/$/, '');
    const apiPath = '/das-pm/pm/definition';
    const url = new URL(`${baseUrl}${apiPath}`);
    const isHttps = url.protocol === 'https:';
    const client = isHttps ? https : http;

    const requestBody = {
      id: workflow.id,
      uniquekey: workflow.uniquekey,
      name: workflow.name,
      description: workflow.description || '',
      version: workflow.version || '1',
      code: workflow.code || '',
      type: workflow.type || '',
      content: JSON.stringify(workflow),
      state: workflow.state !== undefined ? workflow.state : 1,
      params: workflow.params || {}
    };

    const options = {
      hostname: url.hostname,
      port: url.port || (isHttps ? 443 : 80),
      path: url.pathname,
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': `Bearer ${config.apiKey}`
      }
    };

    console.log(`Updating workflow at: ${baseUrl}${apiPath}`);
    console.log(`Method: ${options.method}`);
    console.log(`Unique Key: ${workflow.uniquekey}`);
    console.log(`Database ID: ${workflow.id}`);

    const req = client.request(options, (res) => {
      let data = '';

      res.on('data', (chunk) => {
        data += chunk;
      });

      res.on('end', () => {
        if (res.statusCode >= 200 && res.statusCode < 300) {
          console.log('✓ Workflow updated successfully!');
          const responseData = JSON.parse(data);
          console.log('Response:', JSON.stringify(responseData, null, 2));
          
          const workflowId = responseData.data || responseData.id;
          
          if (workflowId && workflowFile.endsWith('.fix')) {
            try {
              const workflowData = JSON.parse(fs.readFileSync(workflowFile, 'utf8'));
              workflowData.id = workflowId;
              fs.writeFileSync(workflowFile, JSON.stringify(workflowData, null, 2), 'utf8');
              console.log(`✓ Updated workflow file with ID: ${workflowId}`);
            } catch (error) {
              console.warn('⚠ Warning: Failed to update workflow file with ID:', error.message);
            }
          }
          
          resolve(responseData);
        } else {
          console.error(`✗ Failed to update workflow: ${res.statusCode}`);
          console.error('Response:', data);
          reject(new Error(`HTTP ${res.statusCode}: ${res.statusMessage}`));
        }
      });
    });

    req.on('error', (error) => {
      console.error('✗ Error updating workflow:', error.message);
      reject(error);
    });

    req.setTimeout(config.timeout, () => {
      req.destroy();
      reject(new Error(`Request timeout after ${config.timeout}ms`));
    });

    req.write(JSON.stringify(requestBody));
    req.end();
  });
}

function main() {
  const args = process.argv.slice(2);
  
  if (args.length === 0) {
    console.log('Usage: node publish-workflow.js <workflow-file.fix>');
    console.log('');
    console.log('The script will automatically detect whether to create or update based on workflow file.');
    console.log('');
    console.log('Examples:');
    console.log('  node publish-workflow.js examples/leave-request-approval.fix');
    console.log('  node publish-workflow.js examples/order-processing.fix');
    console.log('');
    console.log('Configuration:');
    console.log('  Set environment variables:');
    console.log('    HEARKEN_PM_HOST_IP=192.168.1.100');
    console.log('    HEARKEN_PM_HOST_WEB_PORT=8585');
    console.log('    WORKFLOW_API_KEY=your-api-key-here');
    console.log('  Or create .workflow-config.json in same directory');
    process.exit(1);
  }

  const workflowFile = args[0];
  
  if (!workflowFile) {
    console.error('✗ Workflow file not specified');
    process.exit(1);
  }
  
  if (!fs.existsSync(workflowFile)) {
    console.error(`✗ Workflow file not found: ${workflowFile}`);
    process.exit(1);
  }

  if (!workflowFile.endsWith('.fix')) {
    console.warn('⚠ Warning: Workflow file does not have .fix extension');
  }

  try {
    const config = loadConfig();
    console.log(`Server URL: ${config.serverUrl}`);
    console.log(`Timeout: ${config.timeout}ms`);
    console.log('');

    const workflow = JSON.parse(fs.readFileSync(workflowFile, 'utf8'));
    
    let operation;
    if (workflow.id) {
      operation = 'update';
      console.log(`Detected workflow ID: ${workflow.id}`);
      console.log('Mode: Update existing workflow (PUT)');
    } else {
      operation = 'create';
      console.log('No workflow ID found');
      console.log('Mode: Create new workflow (POST)');
    }
    
    console.log('');
    
    const publishFunction = operation === 'create' ? publishWorkflow : updateWorkflow;
    
    publishFunction(workflowFile, config)
      .then(() => {
        console.log('');
        console.log('=== Operation Complete ===');
        process.exit(0);
      })
      .catch((error) => {
        console.error('');
        console.error('=== Operation Failed ===');
        process.exit(1);
      });
  } catch (error) {
    console.error('✗ Error:', error.message);
    process.exit(1);
  }
}

main();
