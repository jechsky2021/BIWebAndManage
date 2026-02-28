<template>
  <div class="article-detail">
    <!-- 导航栏和分类栏会通过App.vue自动包含 -->
    
    <!-- 文章详情内容 -->
    <main class="main-content">
      <div class="container">
        <div class="content-wrapper">
          <div class="main-column">
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
                <div v-if="loadingRelated" class="loading-state">加载中...</div>
                <div v-else-if="relatedArticles.length > 0" class="related-list">
                  <router-link 
                    v-for="article in relatedArticles" 
                    :key="article.id" 
                    :to="'/article/' + article.id" 
                    class="related-item"
                    target="_blank"
                  >
                    <div class="article-icon" :style="{ backgroundColor: colors[article.id % colors.length] }">{{ article.title.charAt(0) }}</div>
                    <div class="article-info">
                      <h4>{{ article.title }}</h4>
                      <p>{{ article.introduce }}</p>
                    </div>
                  </router-link>
                </div>
                <div v-else class="empty-state">暂无相关推荐</div>
              </div>
            </div>
          </div>
          
          <div class="sidebar">
            <RankingsModule @tabChange="handleTabChange" />
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
import { getArticlesById, getArticlesByPage } from '../api/articles';
import RankingsModule from '../components/RankingsModule.vue';
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
  createTime: ''
});
const relatedArticles = ref<any[]>([]);
const loading = ref(false);
const loadingRelated = ref(false);
const colors = ['#ff6b6b', '#4ecdc4', '#ffe66d', '#1a535c', '#f7b801', '#7209b7', '#4cc9f0', '#f72585'];

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

const handleTabChange = (tab: string) => {
  console.log('Tab changed to:', tab);
  // 可以在这里添加额外的逻辑，比如统计用户行为等
};

const fetchRelatedArticles = async () => {
  try {
    loadingRelated.value = true;
    const data = await getArticlesByPage({
      articleType: -1,
      statuss: 1,
      isRecommend: 1,
      pageNumber: 1,
      pageSize: 3
    });
    console.log('相关推荐:', data);
    if (data.data && data.data.lists) {
      relatedArticles.value = data.data.lists.map((item: any) => ({
        id: item.id,
        title: item.title || '暂无标题',
        introduce: item.introduce || item.content?.substring(0, 100) || '暂无简介'
      }));
    }
  } catch (error) {
    console.error('获取相关推荐失败:', error);
  } finally {
    loadingRelated.value = false;
  }
};

onMounted(() => {
  // 加载文章数据
  console.log('加载文章ID:', articleId.value);
  fetchArticleDetail();
  // 加载相关推荐
  fetchRelatedArticles();
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
    max-width: 1400px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .content-wrapper {
    display: grid;
    grid-template-columns: 1fr 400px;
    gap: 30px;
  }

  .main-column {
    flex: 1;
  }

  .sidebar {
    width: 400px;
    position: sticky;
    top: 30px;
    align-self: start;
  }

  .article-wrapper {
    max-width: 100%;
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

    /* 图片样式 */
    img {
      max-width: 100%;
      height: auto;
    }
    
    /* 块级元素对齐 */
    :deep(p.ql-align-center),
    :deep(div.ql-align-center),
    :deep(li.ql-align-center) {
      text-align: center;
    }
    
    :deep(p.ql-align-right),
    :deep(div.ql-align-right),
    :deep(li.ql-align-right) {
      text-align: right;
    }
    
    :deep(p.ql-align-left),
    :deep(div.ql-align-left),
    :deep(li.ql-align-left) {
      text-align: left;
    }
    
    /* 图片对齐 */
    :deep(p.ql-align-center img),
    :deep(div.ql-align-center img),
    :deep(li.ql-align-center img) {
      display: block;
      margin: 0 auto;
    }
    
    :deep(p.ql-align-right img),
    :deep(div.ql-align-right img),
    :deep(li.ql-align-right img) {
      display: block;
      margin-left: auto;
    }
    
    :deep(p.ql-align-left img),
    :deep(div.ql-align-left img),
    :deep(li.ql-align-left img) {
      display: block;
      margin-right: auto;
    }
    
    /* 图片尺寸控制 */
    :deep(.quill-image) {
      cursor: pointer;
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

    .related-list {
      display: flex;
      flex-direction: column;
      gap: 16px;

      .related-item {
        display: flex;
        gap: 16px;
        background-color: #fff;
        border-radius: 8px;
        padding: 16px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        transition: all 0.3s ease;
        text-decoration: none;

        &:hover {
          transform: translateY(-2px);
          box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
        }

        .article-icon {
          width: 60px;
          height: 60px;
          border-radius: 8px;
          background-color: #ff6b6b;
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: 20px;
          font-weight: bold;
          color: white;
          flex-shrink: 0;
        }

        .article-info {
          flex: 1;

          h4 {
            font-size: 16px;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
            line-height: 1.4;
          }

          p {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            -webkit-line-clamp: 2;
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

  @media (max-width: 1024px) {
    .content-wrapper {
      grid-template-columns: 1fr;
      gap: 20px;
    }

    .sidebar {
      width: 100%;
      position: static;
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