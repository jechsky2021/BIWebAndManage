<template>
  <div class="rankings-module">
    <div class="section-tabs">
      <button 
        v-for="tab in tabs" 
        :key="tab.key"
        :class="['tab', { active: activeTab === tab.key }]"
        @click="switchTab(tab.key)"
        :disabled="activeTab === tab.key"
      >
        {{ tab.name }}
      </button>
    </div>
    
    <div class="rankings-content">
      <div v-if="loading" class="loading-state">
        <div class="loading-spinner"></div>
        <p>加载中...</p>
      </div>
      
      <div v-else>
        <div v-if="activeTab === 'daily'" class="tab-content">
          <LatestArticles :articles="dailyArticles" />
        </div>
        <div v-else-if="activeTab === 'weekly'" class="tab-content">
          <LatestArticles :articles="weeklyArticles" />
        </div>
        <div v-else-if="activeTab === 'monthly'" class="tab-content">
          <LatestArticles :articles="monthlyArticles" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick } from 'vue';
import LatestArticles from './LatestArticles.vue';
import { getArticlesByPage } from '../api/articles';
import dayjs from 'dayjs';

const props = defineProps<{
  initialTab?: string;
}>();

const emit = defineEmits<{
  (e: 'tabChange', tab: string): void;
}>();

const loading = ref(false);
const activeTab = ref(props.initialTab || 'daily');

const tabs: any[] = [
  { key: 'daily', name: '日榜' },
  { key: 'weekly', name: '周榜' },
  { key: 'monthly', name: '月榜' }
];

const dailyArticles = ref<any[]>([]);
const weeklyArticles = ref<any[]>([]);
const monthlyArticles = ref<any[]>([]);

// 计算时间范围的函数
const getTimeRange = (type: 'daily' | 'weekly' | 'monthly') => {
  const now = new Date();
  const endTime = new Date(now);
  endTime.setHours(23, 59, 59, 999);
  
  const startTime = new Date(now);
  
  if (type === 'daily') {
    // 当天开始
    startTime.setHours(0, 0, 0, 0);
  } else if (type === 'weekly') {
    // 本周一开始
    const dayOfWeek = now.getDay() || 7; // 将周日从0改为7
    startTime.setDate(now.getDate() - dayOfWeek + 1);
    startTime.setHours(0, 0, 0, 0);
  } else if (type === 'monthly') {
    // 本月1号开始
    startTime.setDate(1);
    startTime.setHours(0, 0, 0, 0);
  }
  
  return {
    startTime: dayjs(startTime).format('YYYY-MM-DD HH:mm:ss'),
    endTime: dayjs(endTime).format('YYYY-MM-DD HH:mm:ss')
  };
};

const switchTab = async (tabKey: string) => {
  activeTab.value = tabKey;
  emit('tabChange', tabKey);
  
  // 切换标签时获取对应数据
  if (tabKey === 'daily' && dailyArticles.value.length === 0) {
    await fetchDailyArticles();
  } else if (tabKey === 'weekly' && weeklyArticles.value.length === 0) {
    await fetchWeeklyArticles();
  } else if (tabKey === 'monthly' && monthlyArticles.value.length === 0) {
    await fetchMonthlyArticles();
  }
  
  // 可选：添加视觉反馈
  nextTick(() => {
    const activeTabEl = document.querySelector('.tab.active');
    if (activeTabEl) {
      (activeTabEl as HTMLElement).focus();
    }
  });
};

const fetchDailyArticles = async () => {
  try {
    loading.value = true;
    const { startTime, endTime } = getTimeRange('daily');
    const params = {
      articleType: -1,
      statuss: 1,
      isRecommend: -1,
      pageNumber: 1,
      pageSize: 5,
      startTime,
      endTime
    };
    
    const data = await getArticlesByPage(params);
    
    if (data.data && data.data.lists) {
      dailyArticles.value = data.data.lists.map((item: any) => ({
        id: item.id,
        title: item.title || '暂无标题',
        introduce: item.introduce || item.content?.substring(0, 100) || '暂无简介',
        createTime: item.createTime || new Date().toISOString(),
        pageViews: item.pageViews || 0,
        author: item.author || '未知作者'
      }));
    }
  } catch (error) {
    console.error('获取日榜文章失败:', error);
  } finally {
    loading.value = false;
  }
};

const fetchWeeklyArticles = async () => {
  try {
    loading.value = true;
    const { startTime, endTime } = getTimeRange('weekly');
    const params = {
      articleType: -1,
      statuss: 1,
      isRecommend: -1,
      pageNumber: 1,
      pageSize: 5,
      startTime,
      endTime
    };
    
    const data = await getArticlesByPage(params);
    
    if (data.data && data.data.lists) {
      weeklyArticles.value = data.data.lists.map((item: any) => ({
        id: item.id,
        title: item.title || '暂无标题',
        introduce: item.introduce || item.content?.substring(0, 100) || '暂无简介',
        createTime: item.createTime || new Date().toISOString(),
        pageViews: item.pageViews || 0,
        author: item.author || '未知作者'
      }));
    }
  } catch (error) {
    console.error('获取周榜文章失败:', error);
  } finally {
    loading.value = false;
  }
};

const fetchMonthlyArticles = async () => {
  try {
    loading.value = true;
    const { startTime, endTime } = getTimeRange('monthly');
    const params = {
      articleType: -1,
      statuss: 1,
      isRecommend: -1,
      pageNumber: 1,
      pageSize: 5,
      startTime,
      endTime
    };
    
    const data = await getArticlesByPage(params);
    
    if (data.data && data.data.lists) {
      monthlyArticles.value = data.data.lists.map((item: any) => ({
        id: item.id,
        title: item.title || '暂无标题',
        introduce: item.introduce || item.content?.substring(0, 100) || '暂无简介',
        createTime: item.createTime || new Date().toISOString(),
        pageViews: item.pageViews || 0,
        author: item.author || '未知作者'
      }));
    }
  } catch (error) {
    console.error('获取月榜文章失败:', error);
  } finally {
    loading.value = false;
  }
};

onMounted(async () => {
  // 组件挂载后获取日榜数据
  await fetchDailyArticles();
});
</script>

<style lang="scss" scoped>
.rankings-module {
  background-color: #fff;
  border-radius: 8px;
  padding: 24px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

  .section-tabs {
    display: flex;
    border-bottom: 2px solid #f0f0f0;
    margin-bottom: 20px;

    .tab {
      padding: 12px 24px;
      border: none;
      background: none;
      font-size: 16px;
      color: #666;
      cursor: pointer;
      transition: all 0.3s ease;
      border-bottom: 3px solid transparent;

      &:hover {
        color: #ff6b6b;
      }

      &.active {
        color: #ff6b6b;
        border-bottom-color: #ff6b6b;
      }

      &:disabled {
        cursor: default;
      }
    }
  }

  .rankings-content {
    min-height: 400px;

    .loading-state {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 60px 0;
      color: #999;

      .loading-spinner {
        width: 40px;
        height: 40px;
        border: 4px solid #f3f3f3;
        border-top: 4px solid #ff6b6b;
        border-radius: 50%;
        animation: spin 1s linear infinite;
        margin-bottom: 16px;
      }
    }

    .tab-content {
      animation: fadeIn 0.3s ease;
    }
  }

  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }

  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
  }

  @media (max-width: 768px) {
    padding: 16px;

    .section-tabs {
      overflow-x: auto;
      white-space: nowrap;

      .tab {
        padding: 10px 16px;
        font-size: 14px;
      }
    }

    .rankings-content {
      min-height: 300px;
    }
  }

  @media (min-width: 769px) and (max-width: 1024px) {
    padding: 20px;

    .section-tabs {
      .tab {
        padding: 10px 20px;
      }
    }
  }
}
</style>
