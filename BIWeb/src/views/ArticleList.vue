<template>
  <div class="article-list">
    <main class="main-content">
      <div class="container">
        <div class="content-wrapper">
          <div class="main-column">
            <!-- 页面标题 -->
            <div class="page-header">
              <h1 class="page-title">文章列表</h1>
              <p class="page-description">浏览所有美业相关文章</p>
            </div>

            <!-- 筛选和排序 -->
            <div class="filter-bar">
              <div class="filter-options">
                <button class="filter-btn" :class="{ active: activeFilter === 'latest' }" @click="activeFilter = 'latest'">最新</button>
                <button class="filter-btn" :class="{ active: activeFilter === 'hot' }" @click="activeFilter = 'hot'">最热</button>
                <button class="filter-btn" :class="{ active: activeFilter === 'recommend' }" @click="activeFilter = 'recommend'">推荐</button>
              </div>
              <div class="view-mode">
                <button class="view-btn" :class="{ active: activeViewMode === 'list' }" @click="activeViewMode = 'list'">列表</button>
                <button class="view-btn" :class="{ active: activeViewMode === 'grid' }" @click="activeViewMode = 'grid'">网格</button>
              </div>
            </div>

            <!-- 分类筛选 -->
            <div class="category-filter">
              <button 
                v-for="category in categories" 
                :key="category.articleType" 
                class="category-btn"
                :class="{ active: selectedCategory === category.articleType }"
                @click="selectedCategory = category.articleType"
              >
                {{ category.atName }}
              </button>
            </div>

            <!-- 内容列表 -->
            <div class="content-list" :class="{ 'grid-view': activeViewMode === 'grid' }">
              <div 
                v-for="article in filteredArticles" 
                :key="article.id" 
                class="content-item"
                @click="goToDetail(article.id)"
              >
                <div class="content-image">
                  <div class="image-placeholder" :style="{ backgroundColor: article.color }">{{ article.id }}</div>
                </div>
                <div class="content-info">
                  <h3 class="content-title">{{ article.title }}</h3>
                  <p class="content-summary">{{ article.introduce }}</p>
                  <div class="content-meta">
                    <span class="publish-date">{{ dayjs(article.createTime).format('YYYY-MM-DD HH:mm:ss') }}</span>
                    <span class="read-count">阅读 {{ article.pageViews }}</span>
                  </div>
                </div>
              </div>
            </div>

            <!-- 加载状态 -->
            <div v-if="loading" class="loading-state">
              <div class="loading-spinner"></div>
              <p>加载中...</p>
            </div>

            <!-- 空状态 -->
            <div v-if="!loading && filteredArticles.length === 0" class="empty-state">
              <div class="empty-icon">📄</div>
              <p>暂无文章</p>
            </div>

            <!-- 分页 -->
            <div v-if="!loading && filteredArticles.length > 0" class="pagination">
              <button class="page-btn prev" :disabled="currentPage === 1" @click="prevPage">上一页</button>
              <button 
                v-for="page in totalPages" 
                :key="page" 
                class="page-btn" 
                :class="{ active: page === currentPage }"
                @click="currentPage = page"
              >
                {{ page }}
              </button>
              <button class="page-btn next" :disabled="currentPage === totalPages" @click="nextPage">下一页</button>
            </div>

            <!-- 热门标签 -->
            <div class="popular-tags">
              <h3>热门标签</h3>
              <div class="tags-container">
                <span v-for="tag in popularTags" :key="tag" class="tag">{{ tag }}</span>
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

<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue';
import { useRouter } from 'vue-router';
import { getArticlesByPage } from '../api/articles';
import { getArticleTypeByPage } from '../api/articleTypes';
import RankingsModule from '../components/RankingsModule.vue';
import dayjs from 'dayjs';

const router = useRouter();
const currentPage = ref(1);
const totalPages = ref(1);
const articles = ref<any[]>([]);
const categories = ref<any[]>([]);
const selectedCategory = ref<number | null>(null);
const popularTags = ref<string[]>(['染发技巧', '护发知识', '产品测评', '行业动态', '潮流趋势', '专业工具', '护理方法', '色彩搭配']);
const activeFilter = ref('latest');
const activeViewMode = ref('list');
const loading = ref(false);

const handleTabChange = (tab: string) => {
  console.log('Tab changed to:', tab);
  // 可以在这里添加额外的逻辑，比如统计用户行为等
};

const loadCategories = async () => {
  try {
    const response = await getArticleTypeByPage({
      parentId: 9,
      pageNumber: 1,
      pageSize: 20
    });
    
    if (response.data && response.data.lists) {
      categories.value = response.data.lists.map((item: any) => ({
        articleType: item.articleType,
        atName: item.atName || '未分类'
      }));
    }
  } catch (error) {
    console.error('Failed to load categories:', error);
  }
};

const loadArticles = async () => {
  try {
    loading.value = true;
    const params = {
      articleType: selectedCategory.value || -1,
      statuss: 1,
      isRecommend: activeFilter.value === 'recommend' ? 1 : null,
      pageNumber: currentPage.value,
      pageSize: 10
    };

    const response = await getArticlesByPage(params);
    
    if (response.sign === '1' && response.data) {
      articles.value = response.data.lists.map((article: any, index: number) => ({
        id: article.id,
        title: article.title || '暂无标题',
        introduce: article.introduce || article.content?.substring(0, 100) || '暂无简介',
        createTime: article.createTime || new Date().toLocaleDateString(),
        pageViews: article.pageViews || 0,
        color: ['#FF6B6B', '#4ECDC4', '#45B7D1', '#F7DC6F', '#BB8FCE', '#52BE80', '#F8C471', '#85C1E9'][index % 8]
      }));
      
      if (response.data.total) {
        totalPages.value = Math.ceil(response.data.total / 10);
      }
    }
  } catch (error) {
    console.error('Failed to load articles:', error);
  } finally {
    loading.value = false;
  }
};

const goToDetail = (id: number) => {
  router.push(`/article/${id}`);
};

const filteredArticles = computed(() => {
  let filtered = [...articles.value];
  
  switch (activeFilter.value) {
    case 'latest':
      return filtered.sort((a, b) => new Date(b.createTime).getTime() - new Date(a.createTime).getTime());
    case 'hot':
      return filtered.sort((a, b) => b.pageViews - a.pageViews);
    case 'recommend':
      return filtered;
    default:
      return filtered;
  }
});

const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--;
  }
};

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++;
  }
};

onMounted(() => {
  loadCategories();
  loadArticles();
});

watch([currentPage, selectedCategory, activeFilter], () => {
  loadArticles();
});
</script>

<style lang="scss" scoped>
.article-list {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f8f9fa;

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
    grid-template-columns: 1fr 350px;
    gap: 30px;
  }

  .main-column {
    flex: 1;
  }

  .sidebar {
    width: 350px;
    position: sticky;
    top: 30px;
    align-self: start;
  }

  .page-header {
    background-color: #fff;
    padding: 30px;
    border-radius: 8px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

    .page-title {
      font-size: 32px;
      font-weight: bold;
      color: #333;
      margin-bottom: 12px;
    }

    .page-description {
      font-size: 16px;
      color: #666;
      line-height: 1.6;
    }
  }

  .filter-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #fff;
    padding: 16px 20px;
    border-radius: 8px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

    .filter-options {
      display: flex;
      gap: 12px;
    }

    .filter-btn {
      padding: 8px 16px;
      border: 1px solid #e0e0e0;
      background-color: #fff;
      border-radius: 20px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-size: 14px;
      color: #666;

      &:hover {
        background-color: #f5f5f5;
        border-color: #ff6b6b;
        color: #ff6b6b;
      }

      &.active {
        background-color: #ff6b6b;
        color: #fff;
        border-color: #ff6b6b;
      }
    }

    .view-btn {
      padding: 8px 16px;
      border: 1px solid #e0e0e0;
      background-color: #fff;
      border-radius: 20px;
      cursor: pointer;
      transition: all 0.3s ease;

      &:hover {
        background-color: #f5f5f5;
      }

      &.active {
        background-color: #ff6b6b;
        color: #fff;
        border-color: #ff6b6b;
      }
    }

    .view-mode {
      display: flex;
      gap: 8px;
    }
  }

  .category-filter {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    background-color: #fff;
    padding: 16px 20px;
    border-radius: 8px;
    margin-bottom: 20px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

    .category-btn {
      padding: 8px 16px;
      border: 1px solid #e0e0e0;
      background-color: #fff;
      border-radius: 20px;
      cursor: pointer;
      transition: all 0.3s ease;
      font-size: 14px;
      color: #666;

      &:hover {
        background-color: #f5f5f5;
        border-color: #ff6b6b;
        color: #ff6b6b;
      }

      &.active {
        background-color: #ff6b6b;
        color: #fff;
        border-color: #ff6b6b;
      }
    }
  }

  .content-list {
    margin-bottom: 20px;

    &.grid-view {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 20px;
    }
  }

  .content-item {
    display: flex;
    gap: 20px;
    background-color: #fff;
    padding: 20px;
    margin-bottom: 16px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    transition: all 0.3s ease;
    cursor: pointer;

    &:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
    }

    .content-image {
      width: 120px;
      height: 120px;
      border-radius: 6px;
      overflow: hidden;
      flex-shrink: 0;

      .image-placeholder {
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 36px;
        font-weight: bold;
        color: #fff;
      }
    }

    .content-info {
      flex: 1;

      .content-title {
        font-size: 20px;
        font-weight: 600;
        color: #333;
        margin-bottom: 12px;
        line-height: 1.4;
      }

      .content-summary {
        font-size: 14px;
        color: #666;
        line-height: 1.6;
        margin-bottom: 12px;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
      }

      .content-meta {
        display: flex;
        gap: 20px;
        font-size: 13px;
        color: #999;
      }
    }
  }

  .content-list.grid-view .content-item {
    display: flex;
    flex-direction: column;
    margin-bottom: 0;
    height: 100%;

    .content-image {
      width: 100%;
      height: 200px;
      margin-bottom: 16px;
    }

    .content-info {
      .content-title {
        font-size: 18px;
        margin-bottom: 8px;
      }

      .content-summary {
        margin-bottom: 10px;
      }

      .content-meta {
        margin-top: auto;
        flex-wrap: wrap;
        gap: 12px;
      }
    }
  }

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

  .empty-state {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 60px 0;
    color: #999;

    .empty-icon {
      font-size: 64px;
      margin-bottom: 16px;
    }
  }

  @keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
  }

  .pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin-bottom: 30px;

    .page-btn {
      padding: 8px 16px;
      border: 1px solid #e0e0e0;
      background-color: #fff;
      border-radius: 4px;
      cursor: pointer;
      transition: all 0.3s ease;

      &:hover:not(:disabled) {
        border-color: #ff6b6b;
        color: #ff6b6b;
      }

      &:disabled {
        opacity: 0.5;
        cursor: not-allowed;
      }

      &.active {
        background-color: #ff6b6b;
        color: #fff;
        border-color: #ff6b6b;
      }
    }
  }

  .popular-tags {
    background-color: #fff;
    padding: 24px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

    h3 {
      font-size: 18px;
      font-weight: 600;
      color: #333;
      margin-bottom: 16px;
    }

    .tags-container {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;

      .tag {
        padding: 6px 16px;
        background-color: #f0f0f0;
        border-radius: 20px;
        font-size: 14px;
        color: #666;
        cursor: pointer;
        transition: all 0.3s ease;

        &:hover {
          background-color: #ff6b6b;
          color: #fff;
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
    .page-header {
      padding: 20px;

      .page-title {
        font-size: 24px;
      }
    }

    .filter-bar {
      flex-direction: column;
      gap: 16px;
      align-items: stretch;

      .filter-options {
        justify-content: center;
      }

      .view-mode {
        justify-content: center;
      }
    }

    .category-filter {
      justify-content: center;
    }

    .content-item {
      flex-direction: column;
      gap: 16px;

      .content-image {
        width: 100%;
        height: 180px;
      }

      .content-info {
        .content-title {
          font-size: 18px;
        }
      }
    }

    .content-list.grid-view {
      grid-template-columns: 1fr;
      gap: 16px;
    }

    .content-list.grid-view .content-item {
      .content-image {
        height: 160px;
      }

      .content-info {
        .content-title {
          font-size: 16px;
        }
      }
    }

    .pagination {
      flex-wrap: wrap;
    }
  }

  @media (min-width: 769px) and (max-width: 1024px) {
    .content-list.grid-view {
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 16px;
    }
  }
}
</style>
