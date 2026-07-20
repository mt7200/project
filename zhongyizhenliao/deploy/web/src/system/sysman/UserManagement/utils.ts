import {type DepartmentItem} from './type'
/**
 * 组树
 */
export function buildTree(list: DepartmentItem[]) {
  const map = new Map<number, DepartmentItem>()
  const result: DepartmentItem[] = []

  list.forEach(item => {
    map.set(Number(item.id), { ...item, children: [] })
  })

  list.forEach(item => {
    const node = map.get(Number(item.id))!

    const parentId = item.belongto ? Number(item.belongto) : null

    if (!parentId) {
      result.push(node)
    } else {
      map.get(parentId)?.children?.push(node)
    }
  })

  return result
}