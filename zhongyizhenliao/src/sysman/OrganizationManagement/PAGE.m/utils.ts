import { type DepartmentItem } from './type'

/**
 * 组树
 */
export function buildTree(list: DepartmentItem[]) {
  const map = new Map<number, DepartmentItem>()
  const result: DepartmentItem[] = []

  // 先构建 map
  list.forEach(item => {
    map.set(Number(item.id), {
      ...item,
      children: []
    })
  })

  // 再组装树
  list.forEach(item => {
    const node = map.get(Number(item.id))!

    const parentId = Number(item.belongto)

    // 没父级 or 父级不存在
    if (!parentId || !map.has(parentId)) {
      result.push(node)
    } else {
      map.get(parentId)!.children!.push(node)
    }
  })

  return result
}