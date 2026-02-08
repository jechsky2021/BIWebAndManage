<template>
  <div class="flex h-screen overflow-hidden">
    <!-- 侧边栏 -->
    <div class="bg-[#001529] overflow-hidden transition-all duration-300" :class="appStore.sidebar.opened ? 'w-[245px]' : 'w-[64px]'">
      <div class="flex items-center justify-between p-5 bg-[#000c17]">
        <h1 class="m-0 text-xl font-bold text-white" :class="appStore.sidebar.opened ? 'block' : 'hidden'">美业网站后台</h1>
        <el-button 
            circle 
            size="small" 
            @click="appStore.toggleSidebar"
            class="text-white bg-transparent hover:bg-[#1890ff]"
          >
            <el-icon>
              <ArrowLeft v-if="appStore.sidebar.opened" />
              <ArrowRight v-else />
            </el-icon>
          </el-button>
      </div>
      <div class="h-[calc(100%-60px)] overflow-y-auto">
        <el-menu
          :default-active="activeMenu"
          class="el-menu-vertical-demo"
          background-color="#001529"
          text-color="#fff"
          active-text-color="#409EFF"
          router
        >
          <!-- 动态菜单 -->
          <dynamic-menu :menu-data="menuData" />
        </el-menu>
      </div>
    </div>
    
    <!-- 主内容区域 -->
    <div class="flex-1 flex flex-col overflow-hidden">
      <!-- 顶部导航 -->
      <div class="h-[60px] bg-white border-b border-[#e8e8e8] flex items-center justify-between px-5 shadow-[0_2px_8px_rgba(0,0,0,0.09)]">
        <!-- 面包屑导航 -->
      
        <div class="breadcrumb">
          <el-breadcrumb separator="/">
            <el-breadcrumb-item><i class="el-icon-lx-home"></i> 首页</el-breadcrumb-item>
            <el-breadcrumb-item>{{ route.meta.title }}</el-breadcrumb-item>
          </el-breadcrumb>
        </div>
     
        <div>
          <el-dropdown>
            <span class="flex items-center cursor-pointer px-3 py-1 rounded transition-colors duration-300 hover:bg-[#f5f7fa]">
              <el-avatar :size="36" :src="userStore.userInfo.avatar || ''">
                {{ userStore.userInfo.username?.charAt(0) || 'U' }}
              </el-avatar>
              <span class="text-sm text-[#333] ml-2">{{ userStore.userInfo.username || '管理员' }}</span>
              <el-icon class="ml-1"><arrow-down /></el-icon>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="handleLogout">
                  <el-icon><SwitchButton /></el-icon>
                  退出登录
                </el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>
      
      
      <!-- 内容区域 -->
      <div class="flex-1 p-5 overflow-y-auto bg-[#f5f7fa]">
        <router-view />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed, ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useUserStore, useAppStore } from '../stores'
import { ArrowLeft, ArrowRight, SwitchButton, ArrowDown } from '@element-plus/icons-vue'
import DynamicMenu, { type MenuItem } from './DynamicMenu.vue'
import { getMenuList, convertToTree } from '../api/menu'

const route = useRoute()
const router = useRouter()
const userStore = useUserStore()
const appStore = useAppStore()

// 定义菜单数据
const menuData = ref<MenuItem[]>([])

// 加载菜单数据
const loadMenuData = async () => {
  try {
    // 调用API获取菜单数据
    const menuList = await getMenuList()
    console.log('获取到的菜单列表:', menuList)
    
    
    // 将新菜单添加到菜单列表
    const updatedMenuList = [...menuList]
    
    // 将扁平菜单数据转换为树形结构
    menuData.value = convertToTree(updatedMenuList)

    console.log('转换后的树形菜单:', menuData.value)
    
  } catch (error) {
    console.error('加载菜单失败:', error)
    
    // 如果API调用失败，手动创建基础菜单包括小程序配置
    menuData.value = [
      {
        id: 'dashboard',
        mName: '数据概览',
        mParentId: '0',
        mRoute: '/dashboard',
        mIcon: 'PieChart',
        mSort: 1
      } 
    ]
  }
}

// 组件挂载时加载菜单数据
onMounted(() => {
  loadMenuData()
})

// 获取当前激活的菜单
const activeMenu = computed(() => {
  return route.path
})

// 退出登录
const handleLogout = () => {
  userStore.logout()
  router.push('/login')
}
</script>

<style scoped>
/* 菜单样式 - 覆盖Element Plus默认样式 */
:deep(.el-menu) {
  background-color: transparent;
  border-right: none;
}

:deep(.el-menu-item),
:deep(.el-sub-menu__title) {
  display: flex;
  align-items: center;
  padding-left: 20px !important;
}

:deep(.el-menu-item .el-icon),
:deep(.el-sub-menu__title .el-icon) {
  width: 20px;
  text-align: center;
  margin-right: 8px;
}

:deep(.el-menu-item__content) {
  display: flex;
  align-items: center;
}

/* 子菜单样式 */
:deep(.el-sub-menu .el-menu-item) {
  padding-left: 40px !important;
}
</style>
