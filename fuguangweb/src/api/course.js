import http from "../utils/http";
import {reactive, ref} from "vue"

const course = reactive({
    current_direction: 0,  // 当前选中的学习方向，0表示所有方向
    current_category: 0,  // 当前选中的课程分类，0表示不限分类
    direction_list: [],    // 学习方向列表
    category_list: [],    // 课程分类列表
    course_list: [],  // 课程列表数据
    ordering: "",  // 课程排序条件
    page: 1,  // 当前页码，默认为1
    size: 5, // 当前页数据量
    count: 0,  // 课程信息列表的数量
    has_perv: false,  // 是否有上一页
    has_next: false,  // 是否有下一页
    timer: null,  // 课程相关数据的定时器
    text: "", // 搜索字段 搜索文本框内容
    hot_word_list: [],// 热搜词列表
    course_id: null,  // 课程ID
    info: {           // 课程详情信息
        teacher: {},   // 课程相关的老师信息
        discount: {    // 课程相关的折扣信息
            type: ""
        }
    },
    tabIndex: 1,      // 课程详情页中默认展示的课程信息的选项卡
    chapter_list: [],  // 当前课程的章节列表
    course_type: [],  // 课程类型列表
    current_course_type: -1,  // 当前显示的课程类型，默认为-1，表示全部
    user_count: 0,    // 用户中心的课程列表总数
    user_course_list: [], // 用户中心的课程列表
    // 章节课时列表
    lesson_list: [
        // {
        //     id: 1,
        //     label: '1. 概述',
        //     children: [
        //         {id: 4, label: '1.1 基础环境'},
        //     ]
        // }, {
        //     id: 2,
        //     label: '2. 快速入门',
        //     children: [
        //         {id: 5, label: '2.1 基本使用步骤'},
        //         {id: 6, label: '2.2 常用写法'}
        //     ]
        // }, {
        //     id: 3,
        //     label: '3. 路由基础',
        //     children: [
        //         {id: 7, label: '3.1 路由基本概念'},
        //         {id: 8, label: '3.2 普通路由'}
        //     ]
        // }
    ],
    lesson_tree_props: {
        children: 'children',
        label: 'label',
    },
    user_course: {},       // 用户在当前课程的学习进度记录
    current_chapter: null, // 正在学习的章节ID
    current_lesson: null,  // 正在学习的课时ID
    lesson_link: null,  // 正在学习的课时视频ID
    player: null,       // 当前页面的视频播放器对象
    current_time: 0,    // 播放器，当前播放时间
    // 获取学习方向信息
    get_course_direction() {
        return http.get("/courses/directions/")
    },
    // 获取课程分类信息
    get_course_category() {
        return http.get(`/courses/categories/${this.current_direction}/`)
    },
    // 获取课程列表信息
    get_course_list() {
        let params = {
            page: this.page,
            size: this.size,
        }
        if (this.ordering) {
            params.ordering = this.ordering

        }
        return http.get(`/courses/${this.current_direction}/${this.current_category}/`, {

            params,  // params:params的简写
        })
    },
    // 获取课程详情
    get_course() {
        return http.get(`/courses/${this.course_id}`)
    },
    // 获取当前课程的章节信息
    get_course_chapters() {
        return http.get(`/courses/${this.course_id}/chapters/`)
    },
    // 课程相关的优惠活动倒计时
    start_timer() {
        clearInterval(this.timer)
        this.timer = setInterval(() => {
            this.course_list.forEach((course) => {
                // js的对象和Python里面的字典/列表一样，是属于引用类型的，所以修改了成员的值也会影响自身的
                if (course.discount.expire && course.discount.expire > 0) {
                    // 时间不断自减
                    course.discount.expire--
                }
            })
        }, 1000)
    },
    // 搜索课程信息列表
    search_course() {
        let params = {
            page: this.page,
            size: this.size,
            text: this.text,
        }
        if (this.ordering) {
            params["ordering"] = this.ordering
            // params.ordering = this.ordering
        }
        return http.get(`/courses/search`, {
            params,
        })
    },
    get_hot_word() {
        // 课程热搜关键字
        return http.get("/courses/hot_word")
    },
    get_course_type_list(token) {
        // 获取课程类型
        return http.get("/courses/type/")
    },
    get_user_course_list(type, token) {
        // 获取用户的课程列表
        return http.get("/users/course/", {
            params: {
                type: type,
                page: this.page,
                size: this.size,
            },
            headers: {
                Authorization: "jwt " + token,
            }
        })
    },
    get_user_course(token) {
        // 获取用户在指定课程中的学习进度
        return http.get(`/users/course/${this.course_id}`, {
            headers: {
                Authorization: "jwt " + token,
            }
        })
    },
    get_lesson_study_time(lesson, token) {
        // 获取课程课时学习进度时间
        return http.get("/users/lesson/", {
            params: {
                lesson,
            },
            headers: {
                Authorization: "jwt " + token,
            }
        })
    },
    update_user_study_progress(lesson, seed, token) {
        // 更新课时学习的进度
        return http.post('/users/progress/', {
            time: seed,
            lesson: lesson,
        }, {
            headers: {
                Authorization: "jwt " + token,
            }
        })
    }
})

export default course;