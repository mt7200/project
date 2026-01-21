from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)

CORS(app)

app.config['JSON_AS_ASCII'] = False

@app.route('/calculate', methods=['POST'])
def calculate():
    """
    执行计算操作（加减乘除取模）

    :param: data: 包含num1, num2, operation的JSON数据
    :param: num1: 第一个数字
    :param: num2: 第二个数字
    :param: operation: 运算操作，可选值：add, subtract, multiply, divide, modulus
    :return: JSON格式的计算结果，包含result, num1, num2, operation字段
    """
    data = request.get_json()

    if not data:
        return jsonify({'error': '请求数据为空'}), 400

    num1 = data.get('num1')
    num2 = data.get('num2')
    operation = data.get('operation')

    if num1 is None or num2 is None:
        return jsonify({'error': '缺少参数 num1 或 num2'}), 400

    if operation is None:
        return jsonify({'error': '缺少参数 operation'}), 400

    try:
        num1 = float(num1)
        num2 = float(num2)
    except (ValueError, TypeError):
        return jsonify({'error': 'num1 和 num2 必须是数字'}), 400

    if operation == 'add':
        result = num1 + num2
    elif operation == 'subtract':
        result = num1 - num2
    elif operation == 'multiply':
        result = num1 * num2
    elif operation == 'divide':
        if num2 == 0:
            return jsonify({'error': '除数不能为零'}), 400
        result = num1 / num2
    elif operation == 'modulus':
        if num2 == 0:
            return jsonify({'error': '取模运算中除数不能为零'}), 400
        result = num1 % num2
    else:
        return jsonify({'error': '不支持的运算操作'}), 400

    return jsonify({
        'result': result,
        'num1': num1,
        'num2': num2,
        'operation': operation
    })

@app.route('/', methods=['GET'])
def index():
    """
    返回API服务文档

    :return: JSON格式的API文档，包含服务信息和接口说明
    """
    return jsonify({
        'message': '计算器API服务',
        'endpoints': {
            'POST /calculate': {
                'description': '执行计算操作',
                'parameters': {
                    'num1': '第一个数字',
                    'num2': '第二个数字',
                    'operation': '运算操作 (add, subtract, multiply, divide, modulus)'
                }
            }
        }
    })

if __name__ == '__main__':
    app.run(debug=True, port=5000, host='0.0.0.0')
