/**
 * 菜单节点接口
 */
export interface MenuNode {
  belongto: string;
  checkbox: boolean;
  checked: boolean;
  children: MenuNode[];
  cls: string;
  data: FormData;
  expanded: boolean;
  iconCls: string;
  id: string;
  leaf: boolean;
  text: string;
  hasChildren?: boolean;
}

/**
 * 表单数据接口
 */
export interface FormData {
  belongto: string;
  belongto_name: string;
  component_path: string;
  grade: number;
  iconcls: string;
  id?: string;
  is_hide: number;
  is_link: number;
  resource_code: string;
  resource_name: string;
  resource_type: number;
  sequence: number;
  text: string;
}