import http from "../utils/http";
import {reactive, ref} from "vue"

const course = reactive({
    current_direction: 0,  // 当前选中的学习方向，0表示所有方向
    current_category: 0,  // 当前选中的课程分类，0表示不限分类
    direction_list: [],    // 学习方向列表
    category_list: [],    // 课程分类列表
    course_list: [],  // 课程列表数据
    // 获取学习方向信息
    get_course_direction(){
        return http.get("/courses/directions/")
    },
    // 获取课程分类信息
    get_course_category () {
      // return http.get('/courses/categories/',)
        return http.get(`/courses/categories/${this.current_direction}/`)
    },
    // 获取课程列表信息
    get_course_list () {
        return http.get(`/courses/${this.current_direction}/${this.current_category}`)
    }
})

export default course;