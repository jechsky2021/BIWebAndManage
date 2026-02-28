<template>
  <div class="home">
    <!-- 主要内容 -->
    <main class="main-content">
      <div class="container">
        <!-- 顶部轮播 -->
        <div class="carousel">
          <div class="carousel-item">
            <router-link to="/article/1" class="carousel-link">
              <img src="../assets/images/carousel-banner.svg" alt="2026夏季流行发色趋势" class="carousel-image" />
              <div class="carousel-caption">
                <h3>2026夏季流行发色趋势</h3>
                <!-- <p class="trend-description">探索今夏最受欢迎的发色潮流</p> -->
              </div>
            </router-link>
          </div>
        </div>
        
        <!-- 榜单区域 -->
        <div class="content-section">
          <div class="left-column">
            <RankingsModule @tab-change="handleTabChange" />
          </div>
          <div class="right-column">
            <div class="latest-section">
              <h2 class="section-title">最新文章</h2>
              <LatestArticles :articles="latestArticles" />
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
import { ref, onMounted } from 'vue';
import RankingsModule from '../components/RankingsModule.vue';
import LatestArticles from '../components/LatestArticles.vue';
import { getArticlesByPage } from '../api/articles';

const colors = ['#ff6b6b', '#4ecdc4', '#ffe66d', '#1a535c', '#f7b801', '#7209b7', '#4cc9f0', '#f72585'];

const hairColorArticles = ref<any[]>([]);
const hairCareArticles = ref<any[]>([]);
const latestArticles = ref<any[]>([]);

const handleTabChange = (tab: string) => {
  console.log('Tab changed to:', tab);
  // 可以在这里添加额外的逻辑，比如统计用户行为等
};

const fetchLatestArticles = async () => {
  try {
    const data = await getArticlesByPage({
      articleType: -1,
      statuss: 1,
      isRecommend: 1,
      pageNumber: 1,
      pageSize: 10
    });
    
    if (data.data && data.data.lists) {
      latestArticles.value = data.data.lists.map((item: any) => ({
        id: item.id,
        title: item.title || '暂无标题',
        introduce: item.introduce || item.content?.substring(0, 100) || '暂无简介',
        createTime: item.createTime || new Date().toISOString(),
        pageViews: item.pageViews || 0,
        author: item.author || '未知作者'
      }));
    }
  } catch (error) {
    console.error('获取最新文章失败:', error);
  }
};

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

onMounted(async () => {
  // 获取分类文章
  await fetchHairColorArticles();
  await fetchHairCareArticles();
  // 获取最新文章
  await fetchLatestArticles();
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
    max-width: 1400px;
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
  .content-section {
    display: grid;
    grid-template-columns: 1fr 2fr;
    gap: 30px;
    margin-bottom: 40px;
  }

  .left-column {
    display: flex;
    flex-direction: column;
  }

  .right-column {
    display: flex;
    flex-direction: column;
  }

  .latest-section {
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
@media (max-width: 1024px) {
  .content-section {
    grid-template-columns: 1fr;
    gap: 20px;
  }
}

@media (max-width: 768px) {
  .carousel {
    height: 250px;
  }

  .categories-section {
    grid-template-columns: 1fr;
  }
}
</style>