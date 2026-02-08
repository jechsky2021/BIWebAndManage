<template>
  <!-- 页脚 -->
  <footer class="footer">
    <div class="container">
      <div class="footer-content">
        <div class="footer-logo">
          <h2>美业资讯</h2>
          <p>专业的美业行业信息平台</p>
        </div>
        <div class="footer-links">
          <div class="link-group">
            <h3>关于我们</h3>
            <a href="#">公司简介</a>
            <a href="#">联系我们</a>
            <a href="#">加入我们</a>
          </div>
          <div class="link-group">
            <h3>帮助中心</h3>
            <a href="#">使用指南</a>
            <a href="#">常见问题</a>
            <a href="#">用户反馈</a>
          </div>
          <div class="link-group">
            <h3>商务合作</h3>
            <a href="#">广告投放</a>
            <a href="#">内容合作</a>
            <a href="#">活动策划</a>
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <p>&copy; 2025 美业资讯. 保留所有权利.</p>
      </div>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'Footer'
}
</script>

<style lang="scss" scoped>
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