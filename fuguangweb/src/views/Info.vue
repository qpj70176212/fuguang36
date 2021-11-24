<template>
    <div class="detail">
      <Header/>
      <div class="main">
        <div class="course-info">
          <div class="wrap-left">
            <!-- 课程封面图片/视频 -->
            <vue3-video-player
                @play="onPlay($event)"
                @pause="onPause($event)"
                :cover="course.info.course_cover"
                :src="course.info.course_video"
                v-if="course.info.course_video"
            ></vue3-video-player>
            <!--                cover="/src/assets/course-1.png" -->
            <!--                src="/src/assets/1.mp4">-->

            <img :src="course.info.course_cover" style="width: 100%;" alt="" v-else>

          </div>
          <div class="wrap-right">
<!--            <h3 class="course-name">Linux系统基础5周入门精讲</h3>-->
            <h3 class="course-name">{{ course.info.name }}</h3>
<!--            <p class="data">23475人在学&nbsp;&nbsp;&nbsp;&nbsp;课程总时长：148课时/180小时&nbsp;&nbsp;&nbsp;&nbsp;难度：初级</p>-->
            <p class="data">{{ course.info.students }}人在学&nbsp;&nbsp;&nbsp;&nbsp;课程总时长：{{ course.info.pub_lessons }}
              课时/{{ course.info.lessons }}小时&nbsp;&nbsp;&nbsp;&nbsp;难度：{{ course.info.get_level_display }}</p>
<!--            <div class="sale-time">-->
            <div class="sale-time" v-if="course.info.discount.type">
<!--              <p class="sale-type">限时免费</p>-->
              <p class="sale-type">{{ course.info.discount.type }}</p>
<!--              <p class="expire">距离结束：仅剩 01天 04小时 33分 <span class="second">08</span> 秒</p>-->
              <p class="expire" v-if="course.info.discount.expire > 0">距离结束：仅剩 {{ parseInt(course.info.discount.expire/86400) }}天
                {{ fil10(parseInt(course.info.discount.expire/3600%24)) }}小时
                {{ fil10(parseInt(course.info.discount.expire/60%60)) }}分 <span class="second">
                  {{ fil10(parseInt(course.info.discount.expire%60)) }}</span> 秒</p>
            </div>
            <div class="sale-time" v-if="!course.info.discount.type">
               <p class="sale-type">课程价格￥{{ parseFloat(course.info.price).toFixed(2) }}</p>
            </div>
<!--            <p class="course-price">-->
            <p class="course-price" v-if="course.info.discount.price >=0">
              <span>活动价</span>
<!--              <span class="discount">¥0.00</span>-->
              <span class="discount">¥{{ parseFloat(course.info.discount.price).toFixed(2) }}</span>
<!--              <span class="original">¥29.00</span>-->
              <span class="original">¥{{ parseFloat(course.info.price).toFixed(2) }}</span>
            </p>
            <div class="buy">
              <div class="buy-btn">
                <button class="buy-now">立即购买</button>
                <button class="free">免费试学</button>
              </div>
              <div class="add-cart"><img src="../assets/cart-yellow.svg" alt="">加入购物车</div>
            </div>
          </div>
        </div>
        <div class="course-tab">
          <ul class="tab-list">
<!--            <li :class="state.tabIndex===1?'active':''" @click="state.tabIndex=1">详情介绍</li>-->
            <li :class="course.tabIndex===1?'active':''" @click="course.tabIndex=1">详情介绍</li>
            <li :class="course.tabIndex===2?'active':''" @click="course.tabIndex=2">课程章节 <span :class="state.tabIndex!==2?'free':''" v-if="course?.info?.can_free_study">(试学)</span></li>
<!--            <li :class="state.tabIndex===2?'active':''" @click="state.tabIndex=2">课程章节 <span :class="state.tabIndex!==2?'free':''">(试学)</span></li>-->
<!--            <li :class="state.tabIndex===3?'active':''" @click="state.tabIndex=3">用户评论 (42)</li>-->
            <li :class="course.tabIndex===3?'active':''" @click="course.tabIndex=3">用户评论 (42)</li>
            <li :class="course.tabIndex===4?'active':''" @click="course.tabIndex=4">常见问题</li>
<!--            <li :class="state.tabIndex===4?'active':''" @click="state.tabIndex=4">常见问题</li>-->
          </ul>
        </div>
        <div class="course-content">
          <div class="course-tab-list">
<!--            <div class="tab-item" v-if="state.tabIndex===1">-->
            <div class="tab-item" v-if="course.tabIndex===1" v-html="course.info.description"> </div>
<!--              <p><img alt="" src="https://hcdn1.luffycity.com/static/frontend/course/5/21天01_1547098127.6672518.jpeg" width="840"></p>-->
<!--              <p><img alt="" src="https://hcdn1.luffycity.com/static/frontend/course/5/21天01_1547098127.6672518.jpeg" width="840"></p>-->
<!--              <p><img alt="" src="https://hcdn1.luffycity.com/static/frontend/course/5/21天01_1547098127.6672518.jpeg" width="840"></p>-->
<!--            </div>-->
<!--            <div class="tab-item" v-if="state.tabIndex===2">-->
            <div class="tab-item" v-if="course.tabIndex===2">
              <div class="tab-item-title">
                <p class="chapter">课程章节</p>
<!--                <p class="chapter-length">共11章 147个课时</p>-->
                <p class="chapter-length">共{{course?.info?.chapter_list?.length}}章 {{course.info.lessons}}个课时</p>
              </div>
<!--              <div class="chapter-item">-->
              <div class="chapter-item" v-for="chapter in course?.info?.chapter_list">
<!--                <p class="chapter-title"><img src="../assets/1.svg" alt="">第1章·Linux硬件基础</p>-->
                <p class="chapter-title"><img src="../assets/1.svg" alt="">第{{chapter.orders}}章·{{chapter.name}}</p>
                <div class="chapter-title" style="padding-left: 2.4rem;" v-if="chapter.summary" v-html="chapter.summary"></div>
                <ul class="lesson-list">
<!--                  课时列表-->
                  <li class="lesson-item" v-for="lesson in chapter.get_lesson_list">
                    <p class="name"><span class="index">{{chapter.orders}}-{{lesson.orders}}</span> {{lesson.name}}<span class="free" v-if="lesson.free_trail">免费</span></p>
                    <p class="time">{{lesson.duration}} <img src="../assets/chapter-player.svg"></p>
                     <button class="try" v-if="lesson.free_trail">立即试学</button>
                    <button class="try" v-else>购买课程</button>
                  </li>
<!--                  <li class="lesson-item">-->
<!--                    <p class="name"><span class="index">1-1</span> 课程介绍-学习流程<span class="free">免费</span></p>-->
<!--                    <p class="time">07:30 <img src="../assets/chapter-player.svg"></p>-->
<!--                    <button class="try">立即试学</button>-->
<!--                  </li>-->
<!--                  <li class="lesson-item">-->
<!--                    <p class="name"><span class="index">1-2</span> 服务器硬件-详解<span class="free">免费</span></p>-->
<!--                    <p class="time">07:30 <img src="../assets/chapter-player.svg"></p>-->
<!--                    <button class="try">立即试学</button>-->
<!--                  </li>-->
                </ul>
              </div>
<!--              <div class="chapter-item">-->
<!--                <p class="chapter-title"><img src="../assets/1.svg" alt="">第2章·Linux发展过程</p>-->
<!--                <ul class="lesson-list">-->
<!--                  <li class="lesson-item">-->
<!--                    <p class="name"><span class="index">2-1</span> 操作系统组成-Linux发展过程</p>-->
<!--                    <p class="time">07:30 <img src="../assets/chapter-player.svg"></p>-->
<!--                    <button class="try">立即购买</button>-->
<!--                  </li>-->
<!--                  <li class="lesson-item">-->
<!--                    <p class="name"><span class="index">2-2</span> 自由软件-GNU-GPL核心讲解</p>-->
<!--                    <p class="time">07:30 <img src="../assets/chapter-player.svg"></p>-->
<!--                    <button class="try">立即购买</button>-->
<!--                  </li>-->
<!--                </ul>-->
<!--              </div>-->
            </div>
<!--            <div class="tab-item" v-if="state.tabIndex===3">-->
            <div class="tab-item" v-if="course.tabIndex===3">
              用户评论
            </div>
<!--            <div class="tab-item" v-if="state.tabIndex===4">-->
            <div class="tab-item" v-if="course.tabIndex===4">
              常见问题
            </div>
          </div>
          <div class="course-side">
             <div class="teacher-info">
               <h4 class="side-title"><span>授课老师</span></h4>
               <div class="teacher-content">
                 <div class="cont1">
<!--                   <img src="../assets/avatar.jpg">-->
                   <img :src="course.info.teacher.avatar">
                   <div class="name">
<!--                     <p class="teacher-name">李泳谊</p>-->
                     <p class="teacher-name">{{ course.info.teacher.name }}</p>
                     <p class="teacher-title">{{ course.info.teacher.get_role_display }},
                     {{course.info.teacher.title}}</p>
<!--                     <p class="teacher-title">老男孩LInux学科带头人</p>-->
                   </div>
                 </div>
<!--                 <p class="narrative" >Linux运维技术专家，老男孩Linux金牌讲师，讲课风趣幽默、深入浅出、声音洪亮到爆炸</p>-->
                 <div class="narrative" v-html="course.info.teacher.brief"></div>
               </div>
             </div>
          </div>
        </div>
      </div>
      <Footer/>
    </div>
</template>

<script setup>
import {reactive,ref,watch} from "vue"
import {useRoute, useRouter} from "vue-router"
import Header from "../components/Header.vue"
import Footer from "../components/Footer.vue"
import course from "../api/course";
import { ElMessage } from "element-plus";
import {fil10} from "../utils/func";

let route = useRoute()
let router = useRouter()

const state = reactive({
  // course_id: route.params.id,
  tabIndex: 2,
})

// 获取地址栏上面的课程IDcourse_id
course.course_id = route.params.id;
if(course.course_id > 0){
  // 获取课程详情信息
  course.get_course().then(response=>{
    course.info = response.data;
    // 针对优惠课程如果有优惠时间，则进行倒计时处理
    clearInterval(course.timer);
    course.timer = setInterval(()=>{
      if(course.info.discount.expire && course.info.discount.expire>0){
            course.info.discount.expire--
        }
    },1000);

  }).catch(error=>{
    ElMessage.error({
      message: "无效的课程ID！无法获取课程信息！",
      duration: 1000,
      onClose(){
        router.go(-1)
      }
    })
  })
}else{
    ElMessage.error({
      message: "无效的课程ID！无法获取课程信息！",
      duration: 1000,
      onClose(){
        router.go(-1)  //返回上一页
      }
    })
}

// 播放器开始播放视频的回调函数
let onPlay = (event)=>{
    console.log("播放")
    console.log(event);
    console.log(event.target.currentTime); // 当前播放的视频时间进度，可以用于跟踪播放视频的视频
    console.log(event.target.duration); // 当前视频的总时长，可以用于跟踪播放视频的视频
}

// 播放器暂停播放视频的回调函数
let onPause = (event)=>{
    console.log("暂停")
    console.log(event.target.currentTime); // 当前播放的视频时间进度，可以用于跟踪播放视频的视频
    console.log(event.target.duration); // 当前视频的总时长，可以用于跟踪播放视频的视频
}
</script>

<style scoped>
.main{
  background: #fff;
  padding-top: 30px;
}
.course-info{
  width: 1200px;
  margin: 0 auto;
  overflow: hidden;
}
.wrap-left{
  float: left;
  width: 690px;
  height: 388px;
  background-color: #000;
}
.wrap-right{
  float: left;
  position: relative;
  height: 388px;
}
.course-name{
  font-size: 20px;
  color: #333;
  padding: 10px 23px;
  letter-spacing: .45px;
}
.data{
  padding-left: 23px;
  padding-right: 23px;
  padding-bottom: 16px;
  font-size: 14px;
  color: #9b9b9b;
}
.sale-time{
  width: 464px;
  background: #fa6240;
  font-size: 14px;
  color: #4a4a4a;
  padding: 10px 23px;
  overflow: hidden;
}
.sale-type {
  font-size: 16px;
  color: #fff;
  letter-spacing: .36px;
  float: left;
}
.sale-time .expire{
  font-size: 14px;
  color: #fff;
  float: right;
}
.sale-time .expire .second{
  width: 24px;
  display: inline-block;
  background: #fafafa;
  color: #5e5e5e;
  padding: 6px 0;
  text-align: center;
}
.course-price{
  background: #fff;
  font-size: 14px;
  color: #4a4a4a;
  padding: 5px 23px;
}
.discount{
  font-size: 26px;
  color: #fa6240;
  margin-left: 10px;
  display: inline-block;
  margin-bottom: -5px;
}
.original{
  font-size: 14px;
  color: #9b9b9b;
  margin-left: 10px;
  text-decoration: line-through;
}
.buy{
  width: 464px;
  padding: 0px 23px;
  position: absolute;
  left: 0;
  bottom: 20px;
  overflow: hidden;
}
.buy .buy-btn{
  float: left;
}
.buy .buy-now{
  width: 125px;
  height: 40px;
  border: 0;
  background: #ffc210;
  border-radius: 4px;
  color: #fff;
  cursor: pointer;
  margin-right: 15px;
  outline: none;
}
.buy .free{
  width: 125px;
  height: 40px;
  border-radius: 4px;
  cursor: pointer;
  margin-right: 15px;
  background: #fff;
  color: #ffc210;
  border: 1px solid #ffc210;
}
.add-cart{
  float: right;
  font-size: 14px;
  color: #ffc210;
  text-align: center;
  cursor: pointer;
  margin-top: 10px;
}
.add-cart img{
  width: 20px;
  height: 18px;
  margin-right: 7px;
  vertical-align: middle;
}

.course-tab{
    width: 100%;
    background: #fff;
    margin-bottom: 30px;
    box-shadow: 0 2px 4px 0 #f0f0f0;

}
.course-tab .tab-list{
    width: 1200px;
    margin: auto;
    color: #4a4a4a;
    overflow: hidden;
}
.tab-list li{
    float: left;
    margin-right: 15px;
    padding: 26px 20px 16px;
    font-size: 17px;
    cursor: pointer;
}
.tab-list .active{
    color: #ffc210;
    border-bottom: 2px solid #ffc210;
}
.tab-list .free{
    color: #fb7c55;
}
.course-content{
    width: 1200px;
    margin: 0 auto;
    background: #FAFAFA;
    overflow: hidden;
    padding-bottom: 40px;
}
.course-tab-list{
    width: 880px;
    height: auto;
    padding: 20px;
    background: #fff;
    float: left;
    box-sizing: border-box;
    overflow: hidden;
    position: relative;
    box-shadow: 0 2px 4px 0 #f0f0f0;
}
.tab-item{
    width: 880px;
    background: #fff;
    padding-bottom: 20px;
    box-shadow: 0 2px 4px 0 #f0f0f0;
}
.tab-item-title{
    justify-content: space-between;
    padding: 25px 20px 11px;
    border-radius: 4px;
    margin-bottom: 20px;
    border-bottom: 1px solid #333;
    border-bottom-color: rgba(51,51,51,.05);
    overflow: hidden;
}
.chapter{
    font-size: 17px;
    color: #4a4a4a;
    float: left;
}
.chapter-length{
    float: right;
    font-size: 14px;
    color: #9b9b9b;
    letter-spacing: .19px;
}
.chapter-title{
    font-size: 16px;
    color: #4a4a4a;
    letter-spacing: .26px;
    padding: 12px;
    background: #eee;
    border-radius: 2px;
    display: -ms-flexbox;
    display: flex;
    -ms-flex-align: center;
    align-items: center;
}
.chapter-title img{
    width: 18px;
    height: 18px;
    margin-right: 7px;
    vertical-align: middle;
}
.lesson-list{
    padding:0 20px;
}
.lesson-list .lesson-item{
    padding: 15px 20px 15px 36px;
    cursor: pointer;
    justify-content: space-between;
    position: relative;
    overflow: hidden;
}
.lesson-item .name{
    font-size: 14px;
    color: #666;
    float: left;
}
.lesson-item .index{
    margin-right: 5px;
}
.lesson-item .free{
    font-size: 12px;
    color: #fff;
    letter-spacing: .19px;
    background: #ffc210;
    border-radius: 100px;
    padding: 1px 9px;
    margin-left: 10px;
}
.lesson-item .time{
    font-size: 14px;
    color: #666;
    letter-spacing: .23px;
    opacity: 1;
    transition: all .15s ease-in-out;
    float: right;
}
.lesson-item .time img{
    width: 18px;
    height: 18px;
    margin-left: 15px;
    vertical-align: text-bottom;
}
.lesson-item .try{
    width: 86px;
    height: 28px;
    background: #ffc210;
    border-radius: 4px;
    font-size: 14px;
    color: #fff;
    position: absolute;
    right: 20px;
    top: 10px;
    opacity: 0;
    transition: all .2s ease-in-out;
    cursor: pointer;
    outline: none;
    border: none;
}
.lesson-item:hover{
    background: #fcf7ef;
    box-shadow: 0 0 0 0 #f3f3f3;
}
.lesson-item:hover .name{
    color: #333;
}
.lesson-item:hover .try{
    opacity: 1;
}

.course-side{
    width: 300px;
    height: auto;
    margin-left: 20px;
    float: right;
}
.teacher-info{
    background: #fff;
    margin-bottom: 20px;
    box-shadow: 0 2px 4px 0 #f0f0f0;
}
.side-title{
    font-weight: normal;
    font-size: 17px;
    color: #4a4a4a;
    padding: 18px 14px;
    border-bottom: 1px solid #333;
    border-bottom-color: rgba(51,51,51,.05);
}
.side-title span{
    display: inline-block;
    border-left: 2px solid #ffc210;
    padding-left: 12px;
}

.teacher-content{
    padding: 30px 20px;
    box-sizing: border-box;
}

.teacher-content .cont1{
    margin-bottom: 12px;
    overflow: hidden;
}

.teacher-content .cont1 img{
    width: 54px;
    height: 54px;
    margin-right: 12px;
    float: left;
}
.teacher-content .cont1 .name{
    float: right;
}
.teacher-content .cont1 .teacher-name{
    width: 188px;
    font-size: 16px;
    color: #4a4a4a;
    padding-bottom: 4px;
}
.teacher-content .cont1 .teacher-title{
    width: 188px;
    font-size: 13px;
    color: #9b9b9b;
    white-space: nowrap;
}
.teacher-content .narrative{
    font-size: 14px;
    color: #666;
    line-height: 24px;
}
</style>