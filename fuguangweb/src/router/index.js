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

export default router