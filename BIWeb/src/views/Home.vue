<template>
  <div class="home">
    <!-- 主要内容 -->
    <main class="main-content">
      <div class="container">
        <!-- 顶部轮播 -->
        <div class="carousel">
          <div class="carousel-item">
            <router-link to="/article/1" class="carousel-link">
              <img src="../assets/images/carousel-banner.svg" alt="2025夏季流行发色趋势" class="carousel-image" />
              <div class="carousel-caption">
                <h3>2025夏季流行发色趋势</h3>
                <!-- <p class="trend-description">探索今夏最受欢迎的发色潮流</p> -->
              </div>
            </router-link>
          </div>
        </div>
        
        <!-- 榜单区域 -->
        <div class="rankings-section">
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
            
            <div v-if="activeTab === 'latest'" class="tab-content latest-content">
              <LatestArticles :articles="latestArticles" />
            </div>
            <div v-else-if="activeTab === 'daily'" class="tab-content latest-content">
              <LatestArticles :articles="dailyArticles" />
            </div>
            <div v-else-if="activeTab === 'weekly'" class="tab-content latest-content">
              <LatestArticles :articles="weeklyArticles" />
            </div>
            <div v-else-if="activeTab === 'monthly'" class="tab-content latest-content">
              <LatestArticles :articles="monthlyArticles" />
            </div>

          </div>
        </div>

        <!-- 分类内容区 -->
        <div class="categories-section">
          <div class="category-block">
            <h2 class="section-title">单支染膏</h2>
            <div class="articles-grid">
              <router-link v-for="article in hairColorArticles" :key="article.id" :to="'/article/' + article.id" class="article-card">
                <div class="card-image">
                  <div class="article-image-placeholder" :style="{ backgroundColor: colors[article.id % colors.length] }"> {{ article.title.charAt(0) }}</div>
                </div>
                <div class="card-content">
                  <h3 class="card-title">{{ article.title }}</h3>
                  <p class="card-summary">{{ article.introduce }}</p>
                </div>
              </router-link>
            </div>
          </div>
          
          <div class="category-block">
            <h2 class="section-title">洗护产品</h2>
            <div class="articles-grid">
              <router-link v-for="article in hairCareArticles" :key="article.id" :to="'/article/' + article.id" class="article-card">
                <div class="card-image">
                  <div class="article-image-placeholder" :style="{ backgroundColor: colors[article.id % colors.length] }"> {{ article.title.charAt(0) }}</div>
                </div>
                <div class="card-content">
                  <h3 class="card-title">{{ article.title }}</h3>
                  <p class="card-summary">{{ article.introduce }}</p>
                </div>
              </router-link>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick } from 'vue';
import LatestArticles from '../components/LatestArticles.vue';
import { getArticlesByPage } from '../api/articles';
import dayjs from 'dayjs';

 

const loading = ref(false);
const activeTab = ref('latest');

const tabs: any[] = [
  { key: 'latest', name: '最新' },
  { key: 'daily', name: '日榜' },
  { key: 'weekly', name: '周榜' },
  { key: 'monthly', name: '月榜' }
];

const colors = ['#ff6b6b', '#4ecdc4', '#ffe66d', '#1a535c', '#f7b801', '#7209b7', '#4cc9f0', '#f72585'];

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
    startTime: dayjs(startTime).format('YYYY-MM-DD HH:mm:ss') ,
    endTime: dayjs(endTime).format('YYYY-MM-DD HH:mm:ss')
  };
};

const latestArticles = ref<any[]>([
  { 
    id: 16, 
    title: '新品发布：革命性染发技术问世', 
    summary: '这款新产品将改变传统染发方式，提供更持久、更自然的染发效果...', 
    time: '2小时前', 
    source: '美业快讯', 
    views: '3.2万' 
  },
  { 
    id: 17, 
    title: '专家解读：如何应对夏季染发褪色问题', 
    summary: '夏季高温和频繁洗头会导致染发褪色加快，专家教你如何有效保持发色...', 
    time: '5小时前', 
    source: '护发课堂', 
    views: '2.8万' 
  },
  { 
    id: 18, 
    title: '国际美发大赛中国选手荣获金奖', 
    summary: '在刚刚结束的国际美发大赛中，中国选手凭借创新的染发技术获得金奖...', 
    time: '8小时前', 
    source: '国际赛事', 
    views: '2.5万' 
  },
  { 
    id: 19, 
    title: '揭秘：明星染发背后的秘密', 
    summary: '明星们频繁变换发色却依然保持发质健康，他们的造型师分享了专业技巧...', 
    time: '12小时前', 
    source: '明星造型', 
    views: '4.1万' 
  },
  { 
    id: 20, 
    title: '美业店铺如何利用社交媒体提升业绩', 
    summary: '社交媒体已成为美业营销的重要渠道，本文分享如何有效利用各平台引流...', 
    time: '1天前', 
    source: '营销干货', 
    views: '5.6万' 
  },
  { 
    id: 21, 
    title: '2025年秋季染发色彩流行趋势', 
    summary: '今年秋季最受欢迎的发色趋势，从自然棕调到时尚灰调的完美搭配指南...', 
    time: '1天前', 
    source: '色彩趋势', 
    views: '3.8万' 
  },
  { 
    id: 22, 
    title: '专业染发工具使用技巧详解', 
    summary: '掌握专业染发工具的正确使用方法，提升染发效果和客户满意度...', 
    time: '2天前', 
    source: '技术教程', 
    views: '2.9万' 
  },
  { 
    id: 23, 
    title: '染发后头发护理的五大要点', 
    summary: '染发后的头发护理至关重要，专业理发师分享五大护理要点...', 
    time: '2天前', 
    source: '护发专家', 
    views: '4.3万' 
  },
  { 
    id: 24, 
    title: '创业开美业店的投资回报分析', 
    summary: '从选址到运营，全面分析美业创业的投资回报周期和盈利模式...', 
    time: '3天前', 
    source: '创业指南', 
    views: '6.7万' 
  },
  { 
    id: 25, 
    title: '美发师技能提升的进阶路径', 
    summary: '从初级到高级美发师的成长路径，包括技能培训和认证体系...', 
    time: '3天前', 
    source: '职业发展', 
    views: '3.5万' 
  }
]);

const hairColorArticles = ref<any[]>([]);
const hairCareArticles = ref<any[]>([]);

const fetchHairColorArticles = async () => {
  try {
    const data = await getArticlesByPage({
      articleType: 1,
      statuss: 1,
      isRecommend: 1,
      pageNumber: 1,
      pageSize: 3
    });
    console.log("hairColorArticles:", data);
    if (data.data && data.data.lists) {
      hairColorArticles.value = data.data.lists.map((item: any) => ({
        id: item.id,
        title: item.title || '暂无标题',
        introduce: item.introduce || item.content?.substring(0, 100) || '暂无简介'
      }));
    }
  } catch (error) {
    console.error('获取单支染膏文章失败:', error);
  }
};

const fetchHairCareArticles = async () => {
  try {
    const data = await getArticlesByPage({
      articleType: 5,
      statuss: 1,
      isRecommend: 1,
      pageNumber: 1,
      pageSize: 3
    });
    console.log("hairCareArticles:", data);
    if (data.data && data.data.lists) {
      hairCareArticles.value = data.data.lists.map((item: any) => ({
        id: item.id,
        title: item.title || '暂无标题',
        introduce: item.introduce || item.content?.substring(0, 100) || '暂无简介'
      }));
    }
  } catch (error) {
    console.error('获取洗护产品文章失败:', error);
  }
};

const switchTab = async (tabKey: string) => {
  activeTab.value = tabKey;
  
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

const fetchLatestArticles = async () => {
  try {
    loading.value = true;
    const data = await getArticlesByPage({
      articleType: -1,
      statuss: 1,
      isRecommend: 1,
      pageNumber: 1,
      pageSize: 10
    });
    console.log("latestArticles:", data);
    // 假设返回的数据结构与当前的latestArticles格式一致
    if (data.data && data.data.lists) {
      latestArticles.value = data.data.lists;
    }
  } catch (error) {
    console.error('获取最新文章失败:', error);
  } finally {
    loading.value = false;
  }
};

const fetchDailyArticles = async () => {
  try {
    loading.value = true;
    const { startTime, endTime } = getTimeRange('daily');
    const params ={
      articleType: -1,
      statuss: 1,
      isRecommend: 1,
      pageNumber: 1,
      pageSize: 10,
      startTime,
      endTime
    };
    console.log("getArticlesByPage params:",params);
    const data = await getArticlesByPage(params);
    console.log("dailyArticles:", data);
    if (data.data && data.data.lists) {
      dailyArticles.value = data.data.lists;
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
      isRecommend: 1,
      pageNumber: 1,
      pageSize: 10,
      startTime,
      endTime
    };
    console.log("params:",params);
    const data = await getArticlesByPage(params);
    console.log("weeklyArticles:", data);
    if (data.data && data.data.lists) {
      weeklyArticles.value = data.data.lists;
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
    const params ={
      articleType: -1,
      statuss: 1,
      isRecommend: 1,
      pageNumber: 1,
      pageSize: 10,
      startTime,
      endTime
    };
    console.log("params:",params);
    const data = await getArticlesByPage(params);
    console.log("monthlyArticles:", data);
    if (data.data && data.data.lists) {
      monthlyArticles.value = data.data.lists;
    }
  } catch (error) {
    console.error('获取月榜文章失败:', error);
  } finally {
    loading.value = false;
  }
};

onMounted(async () => {
  // 组件挂载后获取最新文章
  await fetchLatestArticles();
  // 预加载日榜数据
  await fetchDailyArticles();
  // 获取分类文章
  await fetchHairColorArticles();
  await fetchHairCareArticles();
});
</script>

<style lang="scss" scoped>
.home {
  min-height: 100%;
}

/* 主要内容样式 */
.main-content {
  flex: 1;
  padding: 20px 0;

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }

  /* 轮播样式 */
  .carousel {
    margin-bottom: 40px;
    border-radius: 8px;
    overflow: hidden;
    position: relative;
    height: 400px;

    .carousel-item {
      position: relative;
      height: 100%;

      .carousel-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        position: absolute;
        top: 0;
        left: 0;
      }

      .carousel-caption {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 30px;
    background: linear-gradient(transparent, rgba(0, 0, 0, 0.8));
    color: #fff;

    h3 {
      font-size: 28px;
      margin-bottom: 10px;
    }

    p {
      font-size: 16px;
      opacity: 0.9;
    }

    .trend-description {
      color: #feca57;
      font-weight: 500;
    }
  }
    }
  }

  /* 榜单样式 */
  .rankings-section {
    margin-bottom: 40px;
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
      }
    }

    .rankings-content {
      .articles-list {
        .article-item {
          display: flex;
          align-items: center;
          padding: 16px 0;
          border-bottom: 1px solid #f5f5f5;
          transition: all 0.2s ease;

          &:last-child {
            border-bottom: none;
          }

          &:hover {
            transform: translateX(5px);
          }

          .rank-number {
            width: 30px;
            height: 30px;
            background-color: #f0f0f0;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-right: 16px;
            flex-shrink: 0;
          }

          &:nth-child(1) .rank-number {
            background-color: #ff6b6b;
            color: #fff;
          }

          &:nth-child(2) .rank-number {
            background-color: #ff9e7d;
            color: #fff;
          }

          &:nth-child(3) .rank-number {
            background-color: #ffdd7d;
            color: #333;
          }

          .article-image {
                  width: 120px;
                  height: 80px;
                  margin-right: 16px;
                  border-radius: 4px;
                  overflow: hidden;
                  flex-shrink: 0;
                  display: flex;
                  align-items: center;
                  justify-content: center;

                  .article-image-placeholder {
                    width: 100%;
                    height: 100%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 24px;
                    font-weight: bold;
                    color: white;
                  }
                }

          .article-info {
            flex: 1;

            .article-title {
              font-size: 18px;
              margin-bottom: 8px;
              font-weight: 500;
              color: #333;
              transition: color 0.2s ease;

              &:hover {
                color: #ff6b6b;
              }
            }

            .article-summary {
              font-size: 14px;
              color: #666;
              margin-bottom: 8px;
              line-height: 1.6;
              overflow: hidden;
              text-overflow: ellipsis;
              display: -webkit-box; 
              -webkit-box-orient: vertical;
            }

            .article-meta {
              display: flex;
              gap: 16px;
              font-size: 14px;
              color: #999;

              .source {
                color: #ff6b6b;
              }
            }
          }
        }
      }
    }
  }

  /* 分类内容样式 */
  .categories-section {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 24px;

    .category-block {
      background-color: #fff;
      border-radius: 8px;
      padding: 24px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

      .section-title {
        font-size: 20px;
        margin-bottom: 20px;
        padding-bottom: 12px;
        border-bottom: 2px solid #f0f0f0;
        color: #333;
      }

      .articles-grid {
        display: flex;
        flex-direction: column;
        gap: 16px;

        .article-card {
          display: flex;
          gap: 16px;
          padding: 12px;
          border-radius: 8px;
          cursor: pointer;
          transition: all 0.3s ease;

          &:hover {
            background-color: #f8f8f8;
            transform: translateX(5px);
          }

          .card-image {
            width: 80px;
            height: 80px;
            border-radius: 4px;
            overflow: hidden;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;

            .article-image-placeholder {
              width: 100%;
              height: 100%;
              display: flex;
              align-items: center;
              justify-content: center;
              font-size: 24px;
              font-weight: bold;
              color: white;
            }
          }

          .card-content {
            flex: 1;

            .card-title {
              font-size: 16px;
              margin-bottom: 8px;
              font-weight: 500;
              color: #333;
              transition: color 0.2s ease;

              &:hover {
                color: #ff6b6b;
              }
            }

            .card-summary {
              font-size: 14px;
              color: #666;
              line-height: 1.6;
              overflow: hidden;
              text-overflow: ellipsis;
              display: -webkit-box;
              -webkit-box-orient: vertical;
            }
          }
        }
      }
    }
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .carousel {
    height: 250px;
  }

  .categories-section {
    grid-template-columns: 1fr;
  }
}
</style>