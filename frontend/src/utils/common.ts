/**
 * 将蛇形命名转为驼峰命名
 */
function toCamel(key: string): string {
  return key.replace(/_([a-z])/g, (_, c) => c.toUpperCase())
}

/**
 * 递归将对象的所有蛇形 key 转为驼峰 key
 */
export function snakeToCamel<T>(obj: unknown): T {
  if (Array.isArray(obj)) {
    return obj.map((item) => snakeToCamel(item)) as T
  }
  if (obj !== null && typeof obj === 'object') {
    const result: Record<string, unknown> = {}
    for (const [key, value] of Object.entries(obj)) {
      result[toCamel(key)] = snakeToCamel(value)
    }
    return result as T
  }
  return obj as T
}

export function exportToCSV(
  data: unknown[],
  filename: string,
  headers: Record<string, string>
) {
  const headerRow = Object.values(headers).join(',')
  const rows = data.map((item) =>
    Object.keys(headers).map((key) => {
      const val = (item as Record<string, unknown>)[key]
      const str = val == null ? '' : String(val)
      return str.includes(',') ? `"${str}"` : str
    }).join(',')
  )
  const csv = [headerRow, ...rows].join('\n')
  const blob = new Blob(['\uFEFF' + csv], { type: 'text/csv;charset=utf-8' })
  const url = URL.createObjectURL(blob)
  const a = document.createElement('a')
  a.href = url
  a.download = `${filename}.csv`
  a.click()
  URL.revokeObjectURL(url)
}

export function formatDate(date: Date | string): string {
  const d = typeof date === 'string' ? new Date(date) : date
  const y = d.getFullYear()
  const m = String(d.getMonth() + 1).padStart(2, '0')
  const day = String(d.getDate()).padStart(2, '0')
  return `${y}-${m}-${day}`
}