<template>
  <div class="article-detail">
    <!-- 导航栏和分类栏会通过App.vue自动包含 -->
    
    <!-- 文章详情内容 -->
    <main class="main-content">
      <div class="container">
        <div class="article-wrapper">
          <!-- 文章头部信息 -->
          <div class="article-header">
            <h1 class="article-title">{{ articleDetail.title }}</h1>
            <div class="article-meta">
              <span class="publish-time">发布时间：{{ formatDate(articleDetail.createTime) }}</span>
              <span class="read-count">阅读：{{ articleDetail.pageViews }}</span>
            </div>
          </div>

          <!-- 文章封面图 -->
          <div class="article-cover">
            <img src="../assets/images/carousel-banner.svg" alt="{{ articleDetail.title }}" class="cover-image" />
          </div>

          <!-- 文章内容 -->
          <div class="article-content">
            <div v-if="loading">加载中...</div>
            <div v-else v-html="articleDetail.content"></div>
          </div>

          <!-- 分享和点赞 -->
          <div class="article-actions">
            <button class="like-btn">
              <span class="like-icon">👍</span>
              <span class="like-count">567</span>
            </button>
            <div class="share-btn">
              <span>分享</span>
              <div class="share-options">
                <span class="share-item">微信</span>
                <span class="share-item">微博</span>
                <span class="share-item">QQ</span>
              </div>
            </div>
          </div>

          <!-- 相关推荐 -->
          <div class="related-articles">
            <h3>相关推荐</h3>
            <div class="related-list">
              <div class="related-item">
                <router-link to="/article/1">
                  <h4>如何护理染后发色</h4>
                  <p>专业的染后护理方法，让你的发色更持久</p>
                </router-link>
              </div>
              <div class="related-item">
                <router-link to="/article/2">
                  <h4>2025秋季发色预测</h4>
                  <p>提前了解下一季的发色趋势</p>
                </router-link>
              </div>
              <div class="related-item">
                <router-link to="/article/3">
                  <h4>不同脸型适合的发色</h4>
                  <p>根据脸型选择最适合你的发色</p>
                </router-link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>

  </div>
</template>
0
<script setup lang="ts">
import { ref, computed, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import { getArticlesById } from '../api/articles';
import dayjs from 'dayjs';


const route = useRoute();
const articleId = computed(() => route.params.id || '1');
const articleDetail = ref<any>({
  id: 0,
  title: '',
  author: '',
  introduce: '',
  articleType: '',
  atName: '',
  content: '',
  statuss: 0,
  pageViews: 0,
  createTime: '',
  relatedArticles: []
});
const loading = ref(false);

const fetchArticleDetail = async () => {
  try {
    loading.value = true;
    const data = await getArticlesById({
      id: Number(articleId.value) 
    });
    console.log('文章详情:', data);
    articleDetail.value = data.data[0] || articleDetail.value;
    console.log('文章详情:', articleDetail.value);
  } catch (error) {
    console.error('获取文章详情失败:', error);
    // 可以添加错误处理，比如显示错误提示
  } finally {
    loading.value = false;
  }
};

const formatDate = (date: string) => {
  if (!date) return '';
  return dayjs(date).format('YYYY-MM-DD HH:mm:ss');
};

onMounted(() => {
  // 加载文章数据
  console.log('加载文章ID:', articleId.value);
  fetchArticleDetail();
});
</script>

<style lang="scss" scoped>
.article-detail {
  min-height: 100vh;
  display: flex;
  flex-direction: column;

  .main-content {
    flex: 1;
    padding: 30px 0;
  }

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .article-wrapper {
    max-width: 800px;
    margin: 0 auto;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
    overflow: hidden;
  }

  .article-header {
    padding: 30px;
    border-bottom: 1px solid #f0f0f0;

    .article-title {
      font-size: 28px;
      font-weight: bold;
      color: #333;
      margin-bottom: 16px;
      line-height: 1.4;
    }

    .article-meta {
      display: flex;
      gap: 20px;
      color: #999;
      font-size: 14px;

      @media (max-width: 768px) {
        flex-direction: column;
        gap: 8px;
      }
    }
  }

  .article-cover {
    width: 100%;
    height: 300px;
    overflow: hidden;

    .cover-image {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  }

  .article-content {
    padding: 30px;
    line-height: 1.8;
    color: #444;

    .lead {
      font-size: 18px;
      color: #666;
      margin-bottom: 30px;
      font-weight: 500;
    }

    h2 {
      font-size: 22px;
      font-weight: bold;
      color: #333;
      margin: 30px 0 16px;
      padding-bottom: 10px;
      border-bottom: 2px solid #ff6b6b;
    }

    h3 {
      font-size: 18px;
      font-weight: bold;
      color: #333;
      margin: 24px 0 12px;
    }

    p {
      margin-bottom: 16px;
      text-align: justify;
    }

    ul {
      margin: 16px 0;
      padding-left: 24px;

      li {
        margin-bottom: 8px;
      }
    }

    .color-showcase {
      display: flex;
      align-items: center;
      gap: 12px;
      margin: 16px 0;
    }

    .color-swatch {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      border: 2px solid #e0e0e0;
      margin-bottom: 8px;
    }

    .tips-box {
      background-color: #f8f9fa;
      border-left: 4px solid #ff6b6b;
      padding: 20px;
      margin: 30px 0;
      border-radius: 4px;
    }
  }

  .article-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 30px;
    border-top: 1px solid #f0f0f0;
    border-bottom: 1px solid #f0f0f0;

    .like-btn,
    .share-btn {
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 8px 16px;
      background-color: #f8f9fa;
      border: 1px solid #e0e0e0;
      border-radius: 20px;
      cursor: pointer;
      transition: all 0.3s ease;

      &:hover {
        background-color: #fff;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      }
    }

    .share-btn {
      position: relative;

      .share-options {
        position: absolute;
        bottom: 100%;
        right: 0;
        background-color: #fff;
        border: 1px solid #e0e0e0;
        border-radius: 8px;
        padding: 12px;
        display: flex;
        flex-direction: column;
        gap: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        opacity: 0;
        visibility: hidden;
        transition: all 0.3s ease;

        .share-item {
          padding: 6px 12px;
          cursor: pointer;
          border-radius: 4px;

          &:hover {
            background-color: #f8f9fa;
          }
        }
      }

      &:hover .share-options {
        opacity: 1;
        visibility: visible;
        transform: translateY(-8px);
      }
    }
  }

  .related-articles {
    padding: 30px;

    h3 {
      font-size: 20px;
      font-weight: bold;
      color: #333;
      margin-bottom: 20px;
    }

    .related-list {
      display: flex;
      flex-direction: column;
      gap: 16px;

      .related-item {
        border: 1px solid #f0f0f0;
        border-radius: 8px;
        overflow: hidden;
        transition: all 0.3s ease;

        &:hover {
          box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
          transform: translateY(-2px);
        }

        a {
          display: block;
          padding: 16px;
          text-decoration: none;

          h4 {
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
          }

          p {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
          }
        }
      }
    }
  }

  .footer {
    background-color: #f8f9fa;
    padding: 30px 0;
    border-top: 1px solid #e0e0e0;

    .footer-content {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 16px;

      p {
        color: #666;
        font-size: 14px;
      }

      .footer-links {
        display: flex;
        gap: 20px;

        a {
          color: #666;
          text-decoration: none;
          font-size: 14px;

          &:hover {
            color: #ff6b6b;
          }
        }

        @media (max-width: 768px) {
          flex-wrap: wrap;
          justify-content: center;
          gap: 12px;
        }
      }
    }
  }

  @media (max-width: 768px) {
    .article-wrapper {
      margin: 0 -20px;
      border-radius: 0;
      box-shadow: none;
    }

    .article-header,
    .article-content,
    .article-actions,
    .related-articles {
      padding: 20px;
    }

    .article-title {
      font-size: 24px !important;
    }

    .article-cover {
      height: 200px;
    }

    .lead {
      font-size: 16px !important;
    }

    h2 {
      font-size: 20px !important;
    }

    h3 {
      font-size: 16px !important;
    }
  }
}
</style>