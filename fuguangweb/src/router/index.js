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
    },
    {
        meta: {
            title: "浮光在线教育-用户注册",
            keepalive: true
        },
        path: "/register",
        name: "Register",  // 路由名称
        component: () => import("../views/Register.vue")
    },
    {
        meta: {
            title: "浮光在线教育-项目课",
            keepalive: true
        },
        path: '/project',
        name: 'Course',
        component: () => import("../views/Course.vue")
    },
    {
      meta:{
        title: "浮光在线教育-项目课详情",
        keepAlive: true
      },
      path: '/project/:id',     // :id vue的路径参数，代表了课程的ID
      name: "Info",
      component: ()=> import("../views/Info.vue"),
    },
    {
      meta:{
        title: "浮光在线教育-购物车",
        keepAlive: true
      },
      path: '/cart',
      name: "Cart",
      component: ()=> import("../views/Cart.vue"),
    }

]

// 路由对象实例化
const router = createRouter({
    // history, 指定路由的模式
    history: createWebHistory(),
    // 路由列表
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