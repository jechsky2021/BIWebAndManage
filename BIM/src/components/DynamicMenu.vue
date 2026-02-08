<template>
  <template v-for="item in menuData" :key="item.id">
    <!-- 子菜单 -->
    <el-sub-menu v-if="item.children && item.children.length > 0" :index="item.id.toString()">
      <template #title>
        <el-icon v-if="getIconComponent(item.mIcon)">
          <component :is="getIconComponent(item.mIcon)" />
        </el-icon>
        <span>{{ appStore.sidebar.opened ? item.mName : '' }}</span>
      </template>
      <!-- 递归调用子菜单 -->
      <DynamicMenu :menu-data="item.children" />
    </el-sub-menu>
    <!-- 单个菜单项 -->
    <el-menu-item v-else :index="item.mRoute || item.id.toString()">
      <el-icon v-if="getIconComponent(item.mIcon)">
        <component :is="getIconComponent(item.mIcon)" />
      </el-icon>
      <template #title>{{ appStore.sidebar.opened ? item.mName : '' }}</template>
    </el-menu-item>
  </template>
</template>

<script setup lang="ts">
// 导入必要的依赖
import { defineComponent } from 'vue'
import { useAppStore } from '../stores'
import {
  PieChart,
  Document,
  RefreshRight,
  Goods,
  Setting,
  Key,
  Printer,
  Tickets,
  User,
  Menu as MenuIcon,
  Setting as SettingIcon,
  List,
  Folder
} from '@element-plus/icons-vue'

// 注册组件名称以支持递归
defineComponent({
  name: 'DynamicMenu'
})

// 定义菜单数据结构接口
export interface MenuItem {
  id: string | number
  mName: string
  mParentId: number | null | string
  mRoute?: string
  mIcon?: string
  mSort: number
  children?: MenuItem[]
  // index?: string
  // path?: string
  // title?: string
  // meta?: {
  //   title: string
  //   icon?: string
  //   [key: string]: any
  // }
}

// 接收父组件传递的菜单数据
defineProps<{
  menuData: MenuItem[]
}>()

// 获取应用状态
const appStore = useAppStore()

// 图标组件映射
const iconMap = {
  PieChart,
  Document,
  RefreshRight,
  Goods,
  Setting,
  SettingIcon,
  Key,
  Printer,
  Tickets,
  User,
  MenuIcon,
  List,
  Folder
}

// 根据图标名称获取图标组件
const getIconComponent = (iconName?: string) => {
  if (!iconName) return null
  return iconMap[iconName as keyof typeof iconMap] || null
}

// 递归组件注册
defineExpose({
  // 可以暴露一些方法给父组件
})
</script>

<style scoped>
/* 菜单样式可以在这里添加，或者继承父组件的样式 */
</style>