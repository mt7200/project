import App from './App.vue'
import { createApp } from 'vue'
import { initStore } from './store'                 // Store
import { initRouter } from './router'               // Router
import language from './locales'                    // 国际化
import '@styles/core/tailwind.css'                  // tailwind
import '@styles/index.scss'                         // 样式
import '@utils/sys/console.ts'                      // 控制台输出内容
import { setupGlobDirectives } from './directives'
import { setupErrorHandle } from './utils/sys/error-handle'
// @ts-ignore
import ClIconSelect from "cl-icon-select";
import ElementPlus from "element-plus";
import 'element-plus/dist/index.css'
import JFUI from 'hearken-web-jfui'
import 'hearken-web-jfui/dist/hearken-web-jfui.css'

document.addEventListener(
  'touchstart',
  function () {},
  { passive: false }
)

const app = createApp(App)
initStore(app)
initRouter(app)
setupGlobDirectives(app)
setupErrorHandle(app)

app.use(language)
app.use(ElementPlus);
app.use(JFUI)
app.use(ClIconSelect);
app.mount('#app')