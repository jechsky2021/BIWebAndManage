<template>
  <div class="beauty-circle">

    <!-- 主要内容 -->
    <main class="main-content">
      <div class="container">
        <!-- <h1 class="page-title">美业圈</h1> -->
        
        <div class="circle-tabs">
          <button 
            v-for="tab in tabs" 
            :key="tab.key"
            :class="['tab', { active: activeTab === tab.key }]"
            @click="activeTab = tab.key"
          >
            {{ tab.name }}
          </button>
        </div>

        <div class="circle-content">
          <!-- 热门话题 -->
            
          <div v-if="activeTab === 'hot'" class="hot-topics">
            <div v-for="topic in hotTopics" :key="topic.id" class="topic-card" @click="goToDetail(topic.id)">
              <div class="topic-header">
                <div class="topic-avatar">
                  <img :src="'/placeholder-avatar.jpg'" :alt="topic.author.name" />
                </div>
                <div class="topic-author">
                  <div class="author-name">{{ topic.author.name }}</div>
                  <div class="author-title">{{ topic.author.title }}</div>
                </div>
                <div class="topic-time">{{ topic.time }}</div>
              </div>
              
              <div class="topic-content">
                <h3 class="topic-title">{{ topic.title }}</h3>
                <p class="topic-description">{{ topic.description }}</p>
                
                <div v-if="topic.images.length > 0" class="topic-images">
                  <img 
                    v-for="(_image, index) in topic.images" 
                    :key="index"
                    :src="'/placeholder-topic.jpg'" 
                    :alt="topic.title"
                  />
                </div>
              </div>
              
              <div class="topic-stats">
                <div class="stat-item">
                  <span class="stat-icon">👍</span>
                  <span class="stat-count">{{ topic.likes }}</span>
                </div>
                <div class="stat-item">
                  <span class="stat-icon">💬</span>
                  <span class="stat-count">{{ topic.comments }}</span>
                </div>
                <div class="stat-item">
                  <span class="stat-icon">🔄</span>
                  <span class="stat-count">{{ topic.shares }}</span>
                </div>
              </div>
            </div>
          </div>
        

          <!-- 美业问答 -->
          <div v-else-if="activeTab === 'qa'" class="qa-section">
            <div class="qa-filters">
              <button 
                :class="['filter-btn', { active: currentFilter === '全部问题' }]" 
                @click="createFilter('全部问题')"
              >
                全部问题
              </button>
              <button 
                :class="['filter-btn', { active: currentFilter === '待回答' }]" 
                @click="createFilter('待回答')"
              >
                待回答
              </button>
              <button 
                :class="['filter-btn', { active: currentFilter === '已解决' }]" 
                @click="createFilter('已解决')"
              >
                已解决
              </button>
            </div>
            
            <div class="qa-list">
              <div v-for="question in filterQuestion" :key="question.id" class="question-card" @click="goToDetail(question.id)">
                <div class="question-header">
                  <div class="question-title">{{ question.title }}</div>
                  <div class="question-tags">
                    <span v-for="tag in question.tags" :key="tag" class="tag">{{ tag }}</span>
                  </div>
                </div>
                
                <div class="question-stats">
                  <span class="stat-text">{{ question.answers }} 回答</span>
                  <span class="stat-text">{{ question.views }} 浏览</span>
                  <span class="stat-text">{{ question.time }}</span>
                </div>
              </div>
            </div>
          </div>

        </div>
      </div>
    </main>

  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRouter } from 'vue-router';

interface Tab {
  key: string;
  name: string;
}

interface Author {
  name: string;
  title: string;
  avatar: string;
}

interface HotTopic {
  id: number;
  title: string;
  description: string;
  images: number[];
  likes: number;
  comments: number;
  shares: number;
  time: string;
  author: Author;
}

interface Question {
  id: number;
  title: string;
  tags: string[];
  answers: number;
  views: number;
  time: string;
  status: string;
}

const router = useRouter();
const filterQuestion = ref<Question[]>([]);
const activeTab = ref('hot');
const currentFilter = ref('全部问题');

const tabs: Tab[] = [
  { key: 'hot', name: '热门话题' },
  { key: 'qa', name: '美业问答' }
  // , { key: 'exchange', name: '行业交流' }
];

const hotTopics: HotTopic[] = [
  {
    id: 1,
    title: '今天遇到一个顾客要求染渐变发色，分享一下我的操作技巧',
    description: '顾客想要从深棕渐变到浅金，发质偏硬，我先用了褪色剂处理发梢部分...',
    images: [1, 2, 3],
    likes: 328,
    comments: 89,
    shares: 42,
    time: '2小时前',
    author: {
      name: '李美发师',
      title: '高级染发师 · 10年经验',
      avatar: '/placeholder-avatar.jpg'
    }
  },
  {
    id: 2,
    title: '大家推荐哪些洗护产品效果比较好？',
    description: '最近想进一批新的洗护产品，客户反馈很重要，想听听同行们的推荐...',
    images: [1],
    likes: 215,
    comments: 134,
    shares: 18,
    time: '5小时前',
    author: {
      name: '张店长',
      title: '美发店店主 · 上海',
      avatar: '/placeholder-avatar.jpg'
    }
  },
  {
    id: 3,
    title: '分享一个烫发后的护理技巧',
    description: '烫发后的护理至关重要，我通常会建议客户使用这些产品和方法...',
    images: [],
    likes: 187,
    comments: 65,
    shares: 32,
    time: '昨天',
    author: {
      name: '王造型师',
      title: '烫发专家 · 北京',
      avatar: '/placeholder-avatar.jpg'
    }
  }
];

const questions: Question[] = [
  {
    id: 1,
    title: '如何解决白发覆盖不持久的问题？',
    tags: ['染发', '白发', '持久度'],
    answers: 12,
    views: 543,
    time: '今天 10:23',
    status: '已解决'
  },
  {
    id: 2,
    title: '染发后头皮过敏怎么办？',
    tags: ['过敏', '染发', '护理'],
    answers: 8,
    views: 321,
    time: '今天 09:15',
    status: '待回答'
  },
  {
    id: 3,
    title: '新店开业如何吸引第一批客户？',
    tags: ['经营', '营销', '新店'],
    answers: 15,
    views: 789,
    time: '昨天',
    status: '已解决'
  }
];


const createFilter = (filter: string) => {
  // 更新当前选中的过滤器
  currentFilter.value = filter;
  
  if (filter === '全部问题') {
    filterQuestion.value = questions;
  } else {
    filterQuestion.value = questions.filter(item => item.status === filter);
  }
};

// 跳转到详情页
const goToDetail = (id: number) => {
  router.push(`/article/${id}`);
};

onMounted(() => {
  filterQuestion.value = questions;
});
</script>

<style lang="scss" scoped>
.beauty-circle {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: #f8f8f8;
}

/* 导航栏样式（与首页相同） */
.navbar {
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 1000;
  padding: 16px 0;

  .container {
    display: flex;
    align-items: center;
    justify-content: space-between;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .logo {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    
    a {
      color: inherit;
      text-decoration: none;
    }
  }

  .nav-links {
    display: flex;
    align-items: center;
    gap: 20px;
  }

  .nav-link {
    color: #666;
    text-decoration: none;
    padding: 8px 16px;
    transition: all 0.3s ease;
    position: relative;
    cursor: pointer;

    &:hover,
    &.active {
      color: #ff6b6b;
    }

    &.active::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 50%;
      transform: translateX(-50%);
      width: 20px;
      height: 3px;
      background-color: #ff6b6b;
      border-radius: 2px;
    }
  }

  .category-dropdown {
    position: relative;
  }

  .dropdown-menu {
    position: absolute;
    top: 100%;
    left: 0;
    background-color: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    border-radius: 4px;
    padding: 8px 0;
    min-width: 120px;
    opacity: 0;
    visibility: hidden;
    transform: translateY(-10px);
    transition: all 0.3s ease;
    z-index: 1001;

    .dropdown-item {
      display: block;
      padding: 8px 16px;
      color: #666;
      text-decoration: none;
      transition: all 0.2s ease;

      &:hover {
        background-color: #f5f5f5;
        color: #ff6b6b;
      }
    }
  }

  .category-dropdown:hover .dropdown-menu {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
  }

  .login-btn {
    padding: 8px 20px;
    background-color: #ff6b6b;
    color: #fff;
    border-radius: 20px;
    text-decoration: none;
    transition: all 0.3s ease;

    &:hover {
      background-color: #ff5252;
      transform: translateY(-2px);
    }
  }
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

  .page-title {
    font-size: 32px;
    margin-bottom: 24px;
    color: #333;
  }

  .circle-tabs {
    display: flex;
    gap: 12px;
    margin-bottom: 24px;
    background-color: #fff;
    padding: 12px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

    .tab {
      flex: 1;
      padding: 12px 24px;
      border: none;
      background: none;
      font-size: 16px;
      color: #666;
      cursor: pointer;
      transition: all 0.3s ease;
      border-radius: 6px;

      &:hover {
        background-color: #f0f0f0;
      }

      &.active {
        background-color: #ff6b6b;
        color: #fff;
      }
    }
  }

  .circle-content {
    /* 热门话题样式 */
    .hot-topics {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
      gap: 24px;

      .topic-card {
        background-color: #fff;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        transition: all 0.3s ease;
        cursor: pointer;

        &:hover {
          transform: translateY(-5px);
          box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
        }

        .topic-header {
          display: flex;
          align-items: center;
          margin-bottom: 16px;

          .topic-avatar {
            width: 48px;
            height: 48px;
            border-radius: 50%;
            overflow: hidden;
            margin-right: 12px;

            img {
              width: 100%;
              height: 100%;
              object-fit: cover;
            }
          }

          .topic-author {
            flex: 1;

            .author-name {
              font-weight: 500;
              color: #333;
              margin-bottom: 4px;
            }

            .author-title {
              font-size: 14px;
              color: #999;
            }
          }

          .topic-time {
            font-size: 14px;
            color: #999;
          }
        }

        .topic-content {
          .topic-title {
            font-size: 18px;
            margin-bottom: 12px;
            color: #333;
            line-height: 1.4;
          }

          .topic-description {
            font-size: 14px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 16px;
          }

          .topic-images {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 8px;
            margin-bottom: 16px;

            img {
              width: 100%;
              aspect-ratio: 1;
              object-fit: cover;
              border-radius: 4px;
            }
          }
        }

        .topic-stats {
          display: flex;
          gap: 24px;

          .stat-item {
            display: flex;
            align-items: center;
            gap: 6px;
            color: #999;
            cursor: pointer;
            transition: color 0.2s ease;

            &:hover {
              color: #ff6b6b;
            }

            .stat-icon {
              font-size: 18px;
            }

            .stat-count {
              font-size: 14px;
            }
          }
        }
      }
    }

    /* 问答区域样式 */
    .qa-section {
      background-color: #fff;
      border-radius: 8px;
      padding: 24px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);

      .qa-filters {
        display: flex;
        gap: 12px;
        margin-bottom: 24px;

        .filter-btn {
          padding: 8px 20px;
          border: 1px solid #e0e0e0;
          background-color: #fff;
          border-radius: 20px;
          cursor: pointer;
          transition: all 0.3s ease;

          &:hover {
            border-color: #ff6b6b;
            color: #ff6b6b;
          }

          &.active {
            background-color: #ff6b6b;
            border-color: #ff6b6b;
            color: #fff;
          }
        }
      }

      .qa-list {
        .question-card {
          padding: 16px 0;
          border-bottom: 1px solid #f0f0f0;

          &:last-child {
            border-bottom: none;
          }

          .question-header {
            margin-bottom: 12px;

            .question-title {
              font-size: 18px;
              color: #333;
              margin-bottom: 8px;
              cursor: pointer;
              transition: color 0.2s ease;

              &:hover {
                color: #ff6b6b;
              }
            }

            .question-tags {
              display: flex;
              gap: 8px;

              .tag {
                padding: 4px 12px;
                background-color: #f0f0f0;
                border-radius: 12px;
                font-size: 12px;
                color: #666;
              }
            }
          }

          .question-stats {
            display: flex;
            gap: 24px;
            font-size: 14px;
            color: #999;
          }
        }
      }
    }

    /* 交流区域样式 */
    .exchange-section {
      .exchange-groups {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 24px;

        .group-card {
          background-color: #fff;
          border-radius: 8px;
          padding: 24px;
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
          transition: all 0.3s ease;

          &:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
          }

          .group-info {
            .group-name {
              font-size: 20px;
              margin-bottom: 12px;
              color: #333;
            }

            .group-description {
              font-size: 14px;
              color: #666;
              line-height: 1.6;
              margin-bottom: 16px;
            }

            .group-stats {
              display: flex;
              gap: 24px;
              margin-bottom: 20px;
              font-size: 14px;
              color: #999;
            }

            .join-btn {
              width: 100%;
              padding: 10px;
              background-color: #ff6b6b;
              color: #fff;
              border: none;
              border-radius: 6px;
              font-size: 16px;
              cursor: pointer;
              transition: all 0.3s ease;

              &:hover {
                background-color: #ff5252;
              }
            }
          }
        }
      }
    }
  }
}

/* 页脚样式（与首页相同） */
.footer {
  background-color: #333;
  color: #fff;
  padding: 40px 0;
  margin-top: auto;

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .footer-content {
    display: flex;
    justify-content: space-between;
    margin-bottom: 40px;

    .footer-logo {
      flex: 0 0 250px;

      h2 {
        font-size: 24px;
        margin-bottom: 12px;
      }

      p {
        color: #ccc;
        font-size: 14px;
      }
    }

    .footer-links {
      display: flex;
      gap: 60px;

      .link-group {
        h3 {
          font-size: 16px;
          margin-bottom: 16px;
          color: #fff;
        }

        a {
          display: block;
          color: #ccc;
          text-decoration: none;
          margin-bottom: 8px;
          font-size: 14px;
          transition: color 0.2s ease;

          &:hover {
            color: #ff6b6b;
          }
        }
      }
    }
  }

  .footer-bottom {
    text-align: center;
    padding-top: 20px;
    border-top: 1px solid #555;
    color: #999;
    font-size: 14px;
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .navbar .container {
    flex-direction: column;
    gap: 16px;
  }

  .nav-links {
    flex-wrap: wrap;
    justify-content: center;
  }

  .page-title {
    font-size: 24px;
  }

  .circle-tabs {
    flex-direction: column;
  }

  .hot-topics,
  .exchange-groups {
    grid-template-columns: 1fr;
  }

  .footer-content {
    flex-direction: column;
    gap: 30px;

    .footer-links {
      flex-wrap: wrap;
      gap: 30px;
    }
  }
}
</style>