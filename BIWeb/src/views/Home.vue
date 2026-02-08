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
                  <p class="card-summary">{{ article.summary }}</p>
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
                  <p class="card-summary">{{ article.summary }}</p>
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

interface Tab {
  key: string;
  name: string;
}

interface Article {
  id: number;
  title: string;
  summary: string;
  time: string;
  source: string;
  views: string;
}

interface CategoryArticle {
  id: number;
  title: string;
  summary: string;
}

const loading = ref(false);
const activeTab = ref('latest');

const tabs: Tab[] = [
  { key: 'latest', name: '最新' },
  { key: 'daily', name: '日榜' },
  { key: 'weekly', name: '周榜' },
  { key: 'monthly', name: '月榜' }
];

const colors = ['#ff6b6b', '#4ecdc4', '#ffe66d', '#1a535c', '#f7b801', '#7209b7', '#4cc9f0', '#f72585'];

const dailyArticles: Article[] = [
  { id: 1, title: '2025夏季流行发色趋势预测', summary: '2025年夏季是发色趋势的重要时间节点，预测显示，许多客户选择使用不同的发色...', time: '2025-08-01', source: '美业观察', views: '23.5万' },
  { id: 2, title: '专业染发师必备的10个技巧', summary: '专业染发师需要掌握的10个技巧，包括选择合适的染膏、正确的染法、及时的维护等...', time: '2025-08-02', source: '染发大师', views: '18.2万' },
  { id: 3, title: '如何解决染发后褪色问题', summary: '染发后褪色是一个常见问题，许多客户都遇到过。本文将介绍一些解决方法，帮助您保持发型的持久和自然...', time: '2025-08-03', source: '护发专家', views: '15.6万' },
  { id: 4, title: '天然植物染发的优缺点分析', summary: '天然植物染发是一种不使用染膏的染法，它的优点包括染后自然、染后持久等...', time: '2025-08-04', source: '绿色美业', views: '12.3万' },
  { id: 5, title: '消费者最喜爱的5款染发产品', summary: '根据消费者调查，以下5款染发产品被广泛认可为最受欢迎的产品...', time: '2025-08-05', source: '美业测评', views: '10.8万' },
  { id: 6, title: '消费者最喜爱的5款染发产品', summary: '根据消费者调查，以下5款染发产品被广泛认可为最受欢迎的产品...', time: '2025-08-05', source: '美业测评', views: '10.8万' },
  { id: 7, title: '消费者最喜爱的5款染发产品', summary: '根据消费者调查，以下5款染发产品被广泛认可为最受欢迎的产品...', time: '2025-08-05', source: '美业测评', views: '10.8万' },
  { id: 8, title: '消费者最喜爱的5款染发产品', summary: '根据消费者调查，以下5款染发产品被广泛认可为最受欢迎的产品...', time: '2025-08-05', source: '美业测评', views: '10.8万' },
  { id: 9, title: '消费者最喜爱的5款染发产品', summary: '根据消费者调查，以下5款染发产品被广泛认可为最受欢迎的产品...', time: '2025-08-05', source: '美业测评', views: '10.8万' },
  { id: 10, title: '消费者最喜爱的5款染发产品', summary: '根据消费者调查，以下5款染发产品被广泛认可为最受欢迎的产品...', time: '2025-08-05', source: '美业测评', views: '10.8万' }
];

const weeklyArticles: Article[] = [
  { id: 6, title: '理发店如何提高染发服务的满意度', summary: '根据客户反馈，以下是一些提高理发师满意度的有效方法...', time: '2025-08-05', source: '美业经营', views: '45.2万' },
  { id: 7, title: '2025年美业市场分析报告', summary: '根据2025年美业市场分析报告，以下是一些重要发现...', time: '2025-08-05', source: '行业研究', views: '38.7万' },
  { id: 8, title: '染发技术进阶培训课程推荐', summary: '本课程将介绍专业染发师必备的10个技巧，帮助您提升染发效果和客户满意度...', time: '2025-08-05', source: '技能提升', views: '32.1万' },
  { id: 9, title: '染发产品成分解析：如何选择安全产品', summary: '根据HairCare.com的研究，以下是一些常用染发产品的成分解析，帮助您选择安全的产品...', time: '2025-08-05', source: '成分科普', views: '29.5万' },
  { id: 10, title: '美业店铺装修设计趋势', summary: '根据最新的店铺装修设计趋势，以下是一些值得关注的方面...', time: '2025-08-05', source: '店铺设计', views: '26.3万' },
  { id: 11, title: '理发店如何提高染发服务的满意度', summary: '根据客户反馈，以下是一些提高理发师满意度的有效方法...', time: '2025-08-05', source: '美业经营', views: '45.2万' },
  { id: 12, title: '2025年美业市场分析报告', summary: '根据2025年美业市场分析报告，以下是一些重要发现...', time: '2025-08-05', source: '行业研究', views: '38.7万' },
  { id: 13, title: '染发技术进阶培训课程推荐', summary: '本课程将介绍专业染发师必备的10个技巧，帮助您提升染发效果和客户满意度...', time: '2025-08-05', source: '技能提升', views: '32.1万' },
  { id: 14, title: '染发产品成分解析：如何选择安全产品', summary: '根据HairCare.com的研究，以下是一些常用染发产品的成分解析，帮助您选择安全的产品...', time: '2025-08-05', source: '成分科普', views: '29.5万' },
  { id: 15, title: '染发产品成分解析：如何选择安全产品', summary: '根据HairCare.com的研究，以下是一些常用染发产品的成分解析，帮助您选择安全的产品...', time: '2025-08-05', source: '成分科普', views: '29.5万' }
];

const monthlyArticles: Article[] = [
  { id: 11, title: '2025年美业十大发展趋势', summary: '根据2025年美业市场分析报告，以下是一些重要发现...', time: '2025-08-05', source: '行业前瞻', views: '120.5万' },
  { id: 12, title: '成功美业创业者的经验分享', summary: '根据成功美业创业者的经验分享，以下是一些重要发现...', time: '2025-08-05', source: '创业故事', views: '98.3万' },
  { id: 13, title: '染发技术的历史演变与未来发展', summary: '根据HairCare.com的研究，以下是一些常用染发产品的成分解析，帮助您选择安全的产品...', time: '2025-08-05', source: '技术演变', views: '87.6万' },
  { id: 14, title: '如何打造高客单价的染发服务', summary: '根据成功美业创业者的经验分享，以下是一些重要发现...', time: '2025-08-05', source: '经营策略', views: '76.2万' },
  { id: 15, title: '美业行业数字化转型指南', summary: '根据2025年美业市场分析报告，以下是一些重要发现...', time: '2025-08-05', source: '数字化', views: '68.9万' },
  { id: 16, title: '如何打造高客单价的染发服务', summary: '根据成功美业创业者的经验分享，以下是一些重要发现...', time: '2025-08-05', source: '经营策略', views: '76.2万' },
  { id: 17, title: '美业行业数字化转型指南', summary: '根据2025年美业市场分析报告，以下是一些重要发现...', time: '2025-08-05', source: '数字化', views: '68.9万' },
  { id: 18, title: '美业行业数字化转型指南', summary: '根据2025年美业市场分析报告，以下是一些重要发现...', time: '2025-08-05', source: '数字化', views: '68.9万' },
  { id: 19, title: '如何打造高客单价的染发服务', summary: '根据成功美业创业者的经验分享，以下是一些重要发现...', time: '2025-08-05', source: '经营策略', views: '76.2万' },
  { id: 20, title: '美业行业数字化转型指南', summary: '根据2025年美业市场分析报告，以下是一些重要发现...', time: '2025-08-05', source: '数字化', views: '68.9万' }
];

const latestArticles = ref<Article[]>([
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

const hairColorArticles: CategoryArticle[] = [
  { id: 21, title: '单支染膏的正确使用方法', summary: '详细介绍单支染膏的操作步骤和注意事项...' },
  { id: 22, title: '如何选择适合客户的染膏颜色', summary: '根据肤色、发质和需求选择最合适的染膏...' },
  { id: 23, title: '单支染膏与双氧奶的最佳搭配比例', summary: '不同发质和颜色需求下的最佳调配方案...' }
];

const hairCareArticles: CategoryArticle[] = [
  { id: 24, title: '染发后如何正确护理头发', summary: '专业洗护产品推荐和日常护理技巧...' },
  { id: 25, title: '修复受损发质的专业方案', summary: '针对染发后受损发质的修复流程...' },
  { id: 26, title: '夏季头发护理的关键点', summary: '高温季节如何保持头发健康和发色持久...' }
];

const scrollToSection = (id: string) => {
  const element = document.getElementById(id);
  if (element) {
    element.scrollIntoView({ behavior: 'smooth' });
  }
};

const switchTab = (tabKey: string) => {
  activeTab.value = tabKey;
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

onMounted(() => {
  // 组件挂载后获取最新文章
  fetchLatestArticles();
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
              -webkit-line-clamp: 2;
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
              -webkit-line-clamp: 2;
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