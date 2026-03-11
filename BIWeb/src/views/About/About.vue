<template>
  <div class="about-page">
    <!-- 页面头部 -->
    <div class="about-header">
      <div class="container">
        <h1>关于我们</h1>
        <p>专业的美业行业信息平台</p>
      </div>
    </div>

    <!-- 主要内容 -->
    <main class="about-content">
      <div class="container">
        <!-- 公司简介 -->
        <section id="company-intro" class="section company-intro">
          <h2>公司简介</h2>
          <div class="section-content">
            <p>美业资讯是一家专注于美业行业的信息平台，致力于为美业从业者和爱好者提供最新、最全面的行业资讯、技术分享和趋势分析。</p>
            <p>我们的使命是通过优质的内容和专业的服务，推动美业行业的健康发展，帮助从业者提升技能，为消费者提供专业的美业知识。</p>
            <p>自成立以来，我们已经服务了数万名美业从业者，成为美业行业最具影响力的信息平台之一。</p>
          </div>
        </section>

        <!-- 我们的优势 -->
        <section class="section our-advantages">
          <h2>我们的优势</h2>
          <div class="advantages-grid">
            <div class="advantage-item">
              <div class="advantage-icon">
                <i class="el-icon-data-analysis"></i>
              </div>
              <h3>专业内容</h3>
              <p>由行业专家和资深从业者提供专业、实用的内容</p>
            </div>
            <div class="advantage-item">
              <div class="advantage-icon">
                <i class="el-icon-time"></i>
              </div>
              <h3>实时更新</h3>
              <p>及时发布行业最新动态和技术趋势</p>
            </div>
            <div class="advantage-item">
              <div class="advantage-icon">
                <i class="el-icon-user"></i>
              </div>
              <h3>社区互动</h3>
              <p>建立美业从业者交流社区，促进知识共享</p>
            </div>
            <div class="advantage-item">
              <div class="advantage-icon">
                <i class="el-icon-mobile"></i>
              </div>
              <h3>多端适配</h3>
              <p>支持PC端、移动端等多种设备访问</p>
            </div>
          </div>
        </section>

        <!-- 联系我们 -->
        <section id="contact-us" class="section contact-us">
          <h2>联系我们</h2>
          <div class="contact-info">
            <div class="contact-item">
              <span class="contact-label">电话：</span>
              <span class="contact-value">400-123-4567</span>
            </div>
            <div class="contact-item">
              <span class="contact-label">邮箱：</span>
              <span class="contact-value">contact@meiye.com</span>
            </div>
            <div class="contact-item">
              <span class="contact-label">地址：</span>
              <span class="contact-value">北京市朝阳区建国路88号</span>
            </div>
          </div>
        </section>

        <!-- 加入我们 -->
        <section id="join-us" class="section join-us">
          <h2>加入我们</h2>
          <div class="section-content">
            <p>我们欢迎热爱美业、有才华的你加入我们的团队。如果你对以下职位感兴趣，请发送简历至 hr@meiye.com：</p>
            <ul class="job-list">
              <li>内容编辑</li>
              <li>技术开发</li>
              <li>市场推广</li>
              <li>客户服务</li>
            </ul>
          </div>
        </section>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

const scrollToSection = (hash: string) => {
  if (hash) {
    const element = document.querySelector(hash)
    if (element) {
      element.scrollIntoView({
        behavior: 'smooth',
        block: 'start'
      })
    }
  }
}

onMounted(() => {
  // 初始加载时检查是否有锚点
  if (route.hash) {
    scrollToSection(route.hash)
  }
})

// 监听路由变化，处理锚点
watch(() => route.hash, (newHash) => {
  if (newHash) {
    scrollToSection(newHash)
  }
})
</script>

<style lang="scss" scoped>
.about-page {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.about-header {
  color: white;
  padding: 60px 0 0 0;
  text-align: center;

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }

  h1 {
    font-size: 36px;
    margin-bottom: 16px;
  }

  p {
    font-size: 18px;
    opacity: 0.9;
  }
}

.about-content {
  flex: 1;
  padding: 60px 0;

  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
  }

  .section {
    margin-bottom: 60px;

    h2 {
      font-size: 24px;
      color: #333;
      margin-bottom: 24px;
      padding-bottom: 12px;
      border-bottom: 2px solid #ff6b6b;
    }

    .section-content {
      line-height: 1.8;
      color: #666;

      p {
        margin-bottom: 16px;
      }
    }
  }

  .advantages-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 30px;
    margin-top: 30px;

    .advantage-item {
      background: #f8f8f8;
      padding: 30px;
      border-radius: 8px;
      text-align: center;
      transition: transform 0.3s ease, box-shadow 0.3s ease;

      &:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      }

      .advantage-icon {
        width: 60px;
        height: 60px;
        background: #ff6b6b;
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
        font-size: 24px;
      }

      h3 {
        font-size: 18px;
        margin-bottom: 12px;
        color: #333;
      }

      p {
        color: #666;
        line-height: 1.6;
      }
    }
  }

  .contact-info {
    background: #f8f8f8;
    padding: 30px;
    border-radius: 8px;

    .contact-item {
      display: flex;
      margin-bottom: 16px;

      .contact-label {
        font-weight: 500;
        width: 80px;
        color: #333;
      }

      .contact-value {
        color: #666;
      }
    }
  }

  .job-list {
    margin-top: 16px;
    padding-left: 20px;

    li {
      margin-bottom: 8px;
      color: #666;
    }
  }
}

/* 响应式设计 */
@media (max-width: 768px) {
  .about-header {
    padding: 40px 0;

    h1 {
      font-size: 28px;
    }

    p {
      font-size: 16px;
    }
  }

  .about-content {
    padding: 40px 0;

    .section {
      margin-bottom: 40px;

      h2 {
        font-size: 20px;
      }
    }

    .advantages-grid {
      grid-template-columns: 1fr;
      gap: 20px;
    }
  }
}
</style>
