<template>
  <div class="player">
    <div id="player"></div>
    <div class="chapter-list">
      <h2>3天django基础</h2>
<!--      <el-tree-->
<!--        highlight-current-->
<!--        class="filter-tree"-->
<!--        :data="course.lesson_list"-->
<!--        :props="course.lesson_tree_props"-->
<!--        default-expand-all-->
<!--        node-key="id"-->
<!--        @node-click="node_click"-->
<!--        >-->
<!--      </el-tree>-->

      <el-tree
          v-if="course.current_lesson"
          highlight-current
          class="filter-tree"
          :data="course.lesson_list"
          :props="course.lesson_tree_props"
          default-expand-all
          node-key="id"
          :current-node-key="course.current_lesson"
          @node-click="node_click"
      >
      </el-tree>
    </div>
  </div>
</template>
<script setup>
import {onMounted, reactive, watch} from "vue"
import http from "../utils/http"
import course from "../api/course";
import "../utils/player"
import {useRoute} from "vue-router";

const route = useRoute()

// 获取路由参数[课程ID]
course.course_id = route.params.course;

// 获取课程信息
course.get_course().then(response => {
  course.user_course = response.data;
  console.log(course.user_course);
  let ret = []
  let chapter_item = {}
  for (let chapter of course.user_course.chapter_list) {
    chapter_item = {id: 'chapter-' + chapter.id, label: `${chapter.orders}. ${chapter.name}`, children: []}
    // 判断当前章节下如果有课时列表
    if (chapter.lesson_list.length > 0) {
      for (let lesson of chapter.lesson_list) {
        chapter_item.children.push({
          id: 'lesson-' + lesson.id,
          label: `${chapter.orders}.${lesson.orders} ${lesson.name}`,
          lesson: lesson
        })
      }
    }
    ret.push(chapter_item)
  }

  course.lesson_list = ret
})

// 当用户点击右侧课程的章节课时的回调函数
const node_click = (data) => {
  if(!data.lesson){
      return ;
  }
  let token = sessionStorage.token || localStorage.token;
  course.get_lesson_study_time(data.lesson.id, token,).then(response=>{
    try {
          // 先删除原来的播放器
          course.player.destroy();
    } catch (error){

    }
    // 重置视频播放时间
    course.current_time = response.data;
    // 重置当前播放的课时ID
    course.current_lesson = data.lesson.id
    // 新建一个播放器
    console.log("data.lesson.lesson_link=", data.lesson.lesson_link)
    polyv(data.lesson.lesson_link);
  })
}

const polyv = (vid) => {
// let polyv = () => {
  let token = sessionStorage.token || localStorage.token;
  // let vid = "94a61789796d49a018b42e8bc0a22997_9"
  // 1. 到数据库中查询当前用户购买的课程是否在有效期内
  var player = polyvPlayer({
  // let player = polyvPlayer({
    wrap: '#player',
    width: document.documentElement.clientWidth - 300, // 页面宽度
    height: document.documentElement.clientHeight,     // 页面高度
    forceH5: true, // 是否用H5播放器
    vid: vid,
    code: "root", // 一般是用户昵称
    // 视频加密播放的配置
    playsafe(vid, next) { // 向后端发送请求获取加密的token
      http.get(`courses/polyv/token/${vid}/`, {
      // http.get(`courses/polyv/token/`, {
      //   params: {
      //     vid: vid,
      //   },
        headers: {
          "Authorization": "jwt " + token,
        }
      }).then(response => {
        // 获取播放视频的token令牌
        next(response.data.token);
      })
    }
  });

  // 设置开始播放视频进度
  course.player.on('s2j_onPlayerInitOver',(e)=>{
    course.player.j2s_seekVideo(course.current_time);
  });

  try {
    // 自动播放
    course.player.j2s_resumeVideo();
  } catch (error){

  }

  // 监听是否是否播放中，更新学习进度
  let video = document.querySelector(".pv-video")
  video.ontimeupdate = ()=>{
    // 每隔几秒，发送一次ajax到服务端更新学习进度和课时进度
    let time = parseInt(video.currentTime)
    if( time % 5 === 0 ){
      if(course.current_time < time){
        course.current_time = time;
      }
    }
  }
}

onMounted(() => {
  polyv();
  // 监听当前浏览器窗口的大小是否发生变化，让播放器随着窗口变化大小
  window.onresize = () => {
    document.querySelector(".pv-video-player").style.width = `${document.documentElement.clientWidth - 300}px`;
    document.querySelector(".pv-video-player").style.height = `${document.documentElement.clientHeight}px`;
  }

  // 开始自动播放
  try {
    course.player.j2s_resumeVideo();
  } catch (error){

  }

  let video = document.querySelector(".pv-video")
  // // 监听是否是否播放中
  video.ontimeupdate = ()=>{
    console.log(video.currentTime)
    // 每隔几秒，发送一次ajax到服务端更新学习进度和课时进度
  }
})
</script>
<style scoped>
.chapter-list {
  position: absolute;
  top: 0;
  right: 0;
  width: 300px;
  background-color: #ccc;
}

.chapter-list h2 {
  height: 40px;
  line-height: 40px;
  text-indent: 1rem;
}
</style>