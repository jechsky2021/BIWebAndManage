<template>
  <div class="content-list">
    <h3 class="section-title">{{ title }}</h3>
    <div v-if="loading" class="loading-state">加载中...</div>
    <div v-else-if="items.length > 0" class="items-list">
      <router-link 
        v-for="item in items" 
        :key="item.id" 
        :to="getItemLink(item)" 
        class="item"
      >
        <div class="item-icon" :style="{ backgroundColor: colors[getColorIndex(item.id)] }">
          {{ item.title?.charAt(0) || 'I' }}
        </div>
        <div class="item-info">
          <h4 class="item-title">{{ item.title }}</h4>
          <p class="item-desc">{{ item.content || '暂无描述' }}</p>
          <div v-if="type === 'question' || type === 'question-like'" class="item-meta">
            <span class="item-status" :class="getStatusClass(item.status)">
              {{ getStatusText(item.status) }}
            </span>
            <span class="item-time">{{ formatDate(item.createTime) }}</span>
          </div>
          <div v-else class="item-time">{{ formatDate(item.createTime) }}</div>
        </div>
      </router-link>
    </div>
    <div v-else class="empty-state">{{ emptyText }}</div>
    
    <div v-if="showPagination && items.length > 0" class="pagination-wrapper">
      <el-pagination
        v-model:current-page="currentPageModel"
        v-model:page-size="pageSizeModel"
        :total="total"
        :page-sizes="[5, 10, 20, 30, 50]"
        layout="total, sizes, prev, pager, next, jumper"
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import dayjs from 'dayjs'

interface Item {
  id: string | number
  title: string
  content?: string
  createTime: string
  status?: number
}

const props = withDefaults(defineProps<{
  title: string
  items: Item[]
  loading: boolean
  type: 'topic' | 'question' | 'topic-like' | 'question-like'
  emptyText: string
  total?: number
  currentPage?: number
  pageSize?: number
  showPagination?: boolean
}>(), {
  total: 0,
  currentPage: 1,
  pageSize: 2,
  showPagination: true
})

const emit = defineEmits<{
  'update:currentPage': [value: number]
  'update:pageSize': [value: number]
  'page-change': [page: number, size: number]
}>()

const colors = ['#ff6b6b', '#4ecdc4', '#ffe66d', '#1a535c', '#f7b801', '#7209b7', '#4cc9f0', '#f72585']

const currentPageModel = computed({
  get: () => props.currentPage,
  set: (value) => emit('update:currentPage', value)
})

const pageSizeModel = computed({
  get: () => props.pageSize,
  set: (value) => emit('update:pageSize', value)
})

const getColorIndex = (id: string | number) => {
  const numId = typeof id === 'string' ? parseInt(id, 10) : id
  return numId % colors.length
}

const getItemLink = (item: Item) => {
  if (props.type === 'question' || props.type === 'question-like') {
    return `/question/${item.id}`
  }
  return `/topic/${item.id}`
}

const formatDate = (date: string) => {
  if (!date) return ''
  return dayjs(date).format('YYYY-MM-DD HH:mm:ss')
}

const getStatusText = (status?: number) => {
  if (status === undefined) return ''
  switch (status) {
    case 0:
      return '待回答'
    case 1:
      return '已回答'
    case 2:
      return '已解决'
    default:
      return '未知'
  }
}

const getStatusClass = (status?: number) => {
  if (status === undefined) return ''
  switch (status) {
    case 0:
      return 'status-pending'
    case 1:
      return 'status-answered'
    case 2:
      return 'status-solved'
    default:
      return ''
  }
}

const handleSizeChange = (size: number) => {
  emit('page-change', props.currentPage, size)
}

const handleCurrentChange = (page: number) => {
  emit('page-change', page, props.pageSize)
}
</script>

<style scoped lang="scss">
.content-list {
  background-color: #fff;
  border-radius: 8px;
  padding: 30px;
  margin: 20px 0;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

  .section-title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    margin-bottom: 20px;
    padding-bottom: 12px;
    border-bottom: 2px solid #f0f0f0;
  }

  .loading-state,
  .empty-state {
    text-align: center;
    padding: 40px 20px;
    color: #999;
    font-size: 14px;
  }

  .items-list {
    display: flex;
    flex-direction: column;
    gap: 16px;
  }

  .item {
    display: flex;
    gap: 16px;
    background-color: #f8f9fa;
    border-radius: 8px;
    padding: 16px;
    transition: all 0.3s ease;
    text-decoration: none;

    &:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .item-icon {
      width: 60px;
      height: 60px;
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
      font-weight: bold;
      color: white;
      flex-shrink: 0;
    }

    .item-info {
      flex: 1;

      .item-title {
        font-size: 16px;
        font-weight: 600;
        color: #333;
        margin-bottom: 8px;
        line-height: 1.4;
      }

      .item-desc {
        font-size: 14px;
        color: #666;
        line-height: 1.6;
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
        margin-bottom: 8px;
      }

      .item-time {
        font-size: 12px;
        color: #999;
      }

      .item-meta {
        display: flex;
        align-items: center;
        gap: 12px;

        .item-status {
          font-size: 12px;
          padding: 2px 8px;
          border-radius: 4px;

          &.status-pending {
            background-color: #fff3cd;
            color: #856404;
          }

          &.status-answered {
            background-color: #d1ecf1;
            color: #0c5460;
          }

          &.status-solved {
            background-color: #d4edda;
            color: #155724;
          }
        }
      }
    }
  }

  .pagination-wrapper {
    margin-top: 20px;
    display: flex;
    justify-content: center;
  }
}
</style>