import {createRouter, createWebHistory} from "vue-router";

// 路由列表
const routes = [
    {
        meta: {
            title: "浮光在线教育-首页",
            keepalive: true
        },
        path: '/',
        name: "Home",
        component: ()=> import("../views/Home.vue")
    },
    {
        meta: {
            title: "浮光在线教育-用户登录",
            keepalive: true
        },
        path: '/login',
        name: "Login",
        component: ()=> import("../views/Login.vue")
    }

]

// 路由对象实例化
const router = createRouter({
    history: createWebHistory(),
    routes,
})

// 客户端权限验证写在路由守卫里面
// 服务端的验证，分2块，1块在客户端的axios附带token，另一块在api服务端的视图中调用permission
router.beforeEach((to, from) => {
    document.title = to.meta.title
    // 返回 false 以取消导航
    // return false
})

export default router