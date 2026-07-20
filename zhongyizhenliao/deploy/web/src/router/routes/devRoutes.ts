/**
 * 开发环境路由
 */
import { AppRouteRecordRaw } from '@/utils/router'

const pageList: any = import.meta.glob([
  '../../system/**/*.vue',
]);


//是否为开发环境

function isDevRoute(): boolean {
  return import.meta.env.DEV 
}

const devRoutes: AppRouteRecordRaw[] = [

]

isDevRoute()&&Object.keys(pageList).forEach((key: any) => {
  const name = key.replace(/^(\.\.\/)+/, '/');
  const component = pageList[key]; 
    devRoutes.push({
      path:   name.toLowerCase() ,
      component: component.default || component,
      name: name 
    });
});


export default devRoutes