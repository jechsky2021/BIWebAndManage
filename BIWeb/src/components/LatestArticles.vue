<template>
  <div class="latest-articles-container">
    <!-- <h3>最新</h3> -->
    <div class="articles-list">
      <router-link 
        v-for="article in articles" 
        :key="article.id" 
        :to="'/article/' + article.id"
        class="article-item"
        target="_blank"
      >
        <div class="article-header">
          <div 
            class="article-icon"
            :style="{ backgroundColor: getRandomColor(article.title) }"
          >
            {{ article.title.charAt(0) }}
          </div>
          <div class="article-info">
            <h4 class="article-title">{{ article.title }}</h4>
            <p class="article-summary">{{ article.introduce }}</p>
          </div>
        </div>
        <div class="article-meta">
          <span class="article-source">{{ article.author }}</span>
          <span class="article-time">{{ formatDate(article.createTime) }}</span>
          <span class="article-views">{{ article.pageViews }} 阅读</span>
        </div>
      </router-link>
    </div>
  </div>
</template>

<script>
import dayjs from 'dayjs';

export default {
  name: 'LatestArticles',
  props: {
    articles: {
      type: Array,
      default: () => []
    }
  },
  methods: {
    // handleArticleClick已通过router-link实现
    formatDate (date) {
      return dayjs(date).format('YYYY-MM-DD');
    },
    getRandomColor(text) {
      const colors = ['#ff6b6b', '#4ecdc4', '#ffe66d', '#1a535c', '#f7b801', '#7209b7', '#4cc9f0', '#f72585'];
      let hash = 0;
      for (let i = 0; i < text.length; i++) {
        hash = text.charCodeAt(i) + ((hash << 5) - hash);
      }
      const index = Math.abs(hash) % colors.length;
      return colors[index];
    }
  }
}
</script>

<style lang="scss" scoped>
.latest-articles-container {
  h3 {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 16px;
    color: #333;
  }

  .articles-list {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 16px;
  }

  .article-item {
    background-color: #fff;
    border-radius: 8px;
    padding: 16px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    cursor: pointer;
    transition: all 0.3s ease;
    text-decoration: none;

    &:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
    }

    .article-header {
      display: flex;
      gap: 12px;
      margin-bottom: 12px;

      .article-icon {
        width: 40px;
        height: 40px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 18px;
        font-weight: bold;
        color: #fff;
        flex-shrink: 0;
      }

      .article-info {
        flex: 1;

        .article-title {
          font-size: 16px;
          font-weight: 600;
          color: #333;
          margin-bottom: 6px;
          line-height: 1.4;
        }

        .article-summary {
          font-size: 14px;
          color: #666;
          line-height: 1.5;
          display: -webkit-box;
          -webkit-line-clamp: 2;
          -webkit-box-orient: vertical;
          overflow: hidden;
          text-overflow: ellipsis;
        }
      }
    }

    .article-meta {
      display: flex;
      align-items: center;
      gap: 16px;
      font-size: 12px;
      color: #999;

      .article-source {
        color: #ff6b6b;
      }

      @media (max-width: 768px) {
        flex-wrap: wrap;
        gap: 8px;
      }
    }
  }

  @media (max-width: 640px) {
    .articles-list {
      grid-template-columns: 1fr;
      gap: 12px;
    }
    
    .article-item {
      padding: 12px;

      .article-header {
        gap: 10px;

        .article-icon {
          width: 32px;
          height: 32px;
          font-size: 14px;
        }

        .article-info {
          .article-title {
            font-size: 14px;
          }

          .article-summary {
            font-size: 12px;
          }
        }
      }

      .article-meta {
        font-size: 11px;
      }
    }
  }
  
  @media (min-width: 641px) {
    .articles-list {
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 16px;
    }
  }
}
</style>