import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    name: 'Home',
    component: () => import('../views/Home.vue')
  },
  {
    path: '/beauty-circle',
    name: 'BeautyCircle',
    component: () => import('../views/BeautyCircle/BeautyCircle.vue')
  },
  {
    path: '/topic/:id',
    name: 'TopicDetail',
    component: () => import('../views/BeautyCircle/TopicDetail.vue'),
    props: true
  },
  {
    path: '/question/:id',
    name: 'QuestionDetail',
    component: () => import('../views/BeautyCircle/QuestionDetail.vue'),
    props: true
  },
  {
    path: '/knowledge',
    name: 'Knowledge',
    component: () => import('../views/Knowledge.vue')
  },
  {
    path: '/articles',
    name: 'ArticleList',
    component: () => import('../views/ArticleList.vue')
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('../views/Login.vue')
  },
  {
    path: '/article/:id',
    name: 'ArticleDetail',
    component: () => import('../views/ArticleDetail.vue'),
    props: true
  },
  {
    path: '/category/:id',
    name: 'CategoryPage',
    component: () => import('../views/CategoryPage.vue'),
    props: true
  },
  {
    path: '/user-center',
    name: 'UserCenter',
    component: () => import('../views/User/UserCenter.vue')
  },
  {
    path: '/tag-manage',
    name: 'TagManage',
    component: () => import('../views/Tags/TagManage.vue')
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router