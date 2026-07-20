declare module 'cl-icon-select' {
  import type { Plugin } from 'vue'

  // 声明插件本身（用于 app.use()）
  const ClIconSelect: Plugin & {
    name: string
  }

  export default ClIconSelect

  // 声明配套的 cl-icon 组件（如果你项目中会用到 <cl-icon>）
  import type { DefineComponent } from 'vue'
  export const ClIcon: DefineComponent<
    {
      name: string
      size?: number | string
      color?: string
    },
    {},
    {}
  >
}