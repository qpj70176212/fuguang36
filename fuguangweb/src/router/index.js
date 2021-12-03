import {createRouter, createWebHistory} from "vue-router";
import {useStore} from "vuex";
import store from "../store";

// 路由列表
const routes = [
    {
        meta: {
            title: "浮光在线教育-首页",
            keepalive: true
        },
        path: '/',
        name: "Home",
        component: () => import("../views/Home.vue")
    },
    {
        meta: {
            title: "浮光在线教育-用户登录",
            keepalive: true
        },
        path: '/login',
        name: "Login",
        component: () => import("../views/Login.vue")
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
        meta: {
            title: "浮光在线教育-项目课详情",
            keepAlive: true
        },
        path: '/project/:id',     // :id vue的路径参数，代表了课程的ID
        name: "Info",
        component: () => import("../views/Info.vue"),
    },
    {
        meta: {
            title: "浮光在线教育-购物车",
            keepAlive: true,
            authorization: true,
        },
        path: '/cart',
        name: "Cart",
        component: () => import("../views/Cart.vue"),
    },
    {
        meta: {
            title: "浮光在线教育-确认订单",
            keepAlive: true,
            authorization: true,
        },
        path: "/order",
        name: "Order",
        component: () => import("../views/Order.vue")
    },
    {
        meta: {
            title: "浮光在线教育-支付成功",
            keepAlive: true
        },
        path: '/alipay',
        name: "AliPaySuccess",
        component: () => import("../views/AliPaySuccess.vue"),
    },
    {
        meta: {
            title: "浮光在线教育-会员中心",
            keepAlive: true
        },
        path: '/user',
        name: "User",
        component: () => import("../views/User.vue"),
        children: [
            {
                meta: {
                    title: "浮光在线教育-个人信息",
                    keepAlive: true,
                    authorization: true,
                },
                path: '',
                name: "UserInfo",
                component: () => import("../components/Info.vue"),
            },
            {
                meta: {
                    title: "浮光在线教育-我的课程",
                    keepAlive: true
                },
                path: 'course',
                name: "UserCourse",
                component: ()=> import("../components/Course.vue"),
            },
            {
                meta: {
                    title: "浮光在线教育-我的订单",
                    keepAlive: true,
                    authorization: true,
                },
                path: 'order',
                name: "UserOrder",
                component: () => import("../components/Order.vue"),
            },
            // {
            //     meta: {
            //         title: "我的余额",
            //         keepAlive: true
            //     },
            //     path: 'balance',
            //     name: "UserBalance",
            //     // component: ()=> import("../components/Balance.vue"),
            // },
            // {
            //     meta: {
            //         title: "我的优惠券",
            //         keepAlive: true
            //     },
            //     path: 'coupon',
            //     name: "UserCoupon",
            //     // component: ()=> import("../components/Coupon.vue"),
            // },
            // {
            //     meta: {
            //         title: "我的消费记录",
            //         keepAlive: true
            //     },
            //     path: 'bill',
            //     name: "UserBill",
            //     // component: ()=> import("../components/Bill.vue"),
            // },
        ]
    },
    {
      meta:{
        title: "个人中心-学习中心",
        keepAlive: true,
        authorization: true
      },
      // path: '/user/study/',
      path: '/user/study/:course',
      name: "Study",
      component: ()=> import("../views/Study.vue"),
    },
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
router.beforeEach((to, from,next) => {
    document.title = to.meta.title
    // 登录状态验证
    // let store = useStore()
    if (to.meta.authorization && !store.getters.getUserInfo) {
        // console.log("验证用户的登录状态")
        // console.log(store)
        next({"name": "Login"})
    } else {
        next()
    }
    // 返回 false 以取消导航
    // return false
})

export default router