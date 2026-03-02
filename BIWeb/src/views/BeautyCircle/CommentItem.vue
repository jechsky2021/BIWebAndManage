<template>
  <div class="comment-item-wrapper">
    <div class="comment-main">
      <div class="comment-avatar">
        <img :src="getAvatarUrl(comment.uAvatar) || '/placeholder-avatar.jpg'" :alt="comment.uName" />
      </div>
      <div class="comment-content">
        <div class="comment-header">
          <span class="comment-author">{{ comment.uName || '匿名用户' }}</span>
          <span v-if="parentAuthor" class="reply-to">回复</span>
          <span v-if="parentAuthor" class="parent-author">{{ parentAuthor }}</span>
          <span class="comment-time">{{ dayjs(comment.createTime).format('YYYY-MM-DD HH:mm:ss') }}</span>
        </div>
        <div class="comment-text">{{ comment.content }}</div>
        <div class="comment-actions">
          <span class="reply-btn" @click="showReplyForm(comment.id)">回复</span>
        </div>

        <!-- 回复表单 -->
        <div v-if="replyingTo === comment.id" class="reply-form">
          <el-input
            v-model="replyForm.content"
            type="textarea"
            :rows="2"
            :placeholder="`回复 ${comment.uName}...`"
            maxlength="500"
            show-word-limit
          />
          <div class="reply-form-actions">
            <el-button size="small" @click="cancelReply">取消</el-button>
            <el-button size="small" type="primary" @click="handleSubmitReply(comment.id)" :loading="replyLoading">
              回复
            </el-button>
          </div>
        </div>

        <!-- 递归子评论 -->
        <div v-if="childComments.length > 0" class="child-comments">
          <CommentItem
            v-for="childComment in childComments"
            :key="childComment.id"
            :comment="childComment"
            :all-comments="allComments"
            :replying-to="replyingTo"
            :reply-loading="replyLoading"
            :reply-form="replyForm"
            :topic-id="topicId"
            @show-reply="showReplyForm"
            @cancel-reply="cancelReply"
            @submit-reply="handleSubmitReply"
            @refresh-comments="refreshComments"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { getAvatarUrl } from '../../utils/helpers'
import dayjs from 'dayjs';

const props = defineProps<{
  comment: any
  allComments: any[]
  replyingTo: number | null
  replyLoading: boolean
  replyForm: { content: string }
  topicId: string
}>()

const emit = defineEmits<{
  (e: 'showReply', commentId: number): void
  (e: 'cancelReply'): void
  (e: 'submitReply', parentId: number): void
  (e: 'refreshComments'): void
}>()

// 获取子评论
const childComments = computed(() => {
  return props.allComments.filter(c => c.parentId === props.comment.id)
})

// 获取父评论作者名
const parentAuthor = computed(() => {
  if (!props.comment.parentId || props.comment.parentId === 0) return null
  const parent = props.allComments.find(c => c.id === props.comment.parentId)
  return parent?.uName || null
})

const showReplyForm = (commentId: number) => {
  emit('showReply', commentId)
}

const cancelReply = () => {
  emit('cancelReply')
}

const handleSubmitReply = (parentId: number) => {
  emit('submitReply', parentId)
}

const refreshComments = () => {
  emit('refreshComments')
}
</script>

<style lang="scss" scoped>
.comment-item-wrapper {
  .comment-main {
    display: flex;
    gap: 12px;
    padding: 16px 0;
    border-bottom: 1px solid #f0f0f0;

    &:last-child {
      border-bottom: none;
    }

    .comment-avatar {
      flex-shrink: 0;

      img {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
      }
    }

    .comment-content {
      flex: 1;
      min-width: 0;

      .comment-header {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 8px;
        flex-wrap: wrap;

        .comment-author {
          font-size: 14px;
          font-weight: 500;
          color: #333;
        }

        .reply-to {
          font-size: 12px;
          color: #999;
        }

        .parent-author {
          font-size: 14px;
          color: #ff6b6b;
          font-weight: 500;
        }

        .comment-time {
          font-size: 12px;
          color: #999;
        }
      }

      .comment-text {
        font-size: 14px;
        line-height: 1.6;
        color: #666;
        word-break: break-word;
      }

      .comment-actions {
        margin-top: 8px;

        .reply-btn {
          font-size: 13px;
          color: #999;
          cursor: pointer;
          transition: color 0.3s;

          &:hover {
            color: #ff6b6b;
          }
        }
      }

      .reply-form {
        margin-top: 12px;
        padding: 12px;
        background: #f8f8f8;
        border-radius: 8px;

        .reply-form-actions {
          margin-top: 8px;
          display: flex;
          justify-content: flex-end;
          gap: 8px;

          .el-button--primary {
            background-color: #ff6b6b;
            border-color: #ff6b6b;

            &:hover {
              background-color: #ff5252;
              border-color: #ff5252;
            }
          }
        }
      }

      .child-comments {
        margin-top: 16px;
        padding-left: 20px;
        border-left: 2px solid #f0f0f0;

        .comment-item-wrapper {
          .comment-main {
            padding: 12px 0;

            &:first-child {
              padding-top: 0;
            }

            .comment-avatar {
              img {
                width: 32px;
                height: 32px;
              }
            }

            .comment-content {
              .comment-header {
                margin-bottom: 4px;

                .comment-author {
                  font-size: 13px;
                }

                .parent-author {
                  font-size: 13px;
                }

                .comment-time {
                  font-size: 12px;
                }
              }

              .comment-text {
                font-size: 13px;
                line-height: 1.5;
              }

              .comment-actions {
                margin-top: 6px;

                .reply-btn {
                  font-size: 12px;
                }
              }
            }
          }
        }
      }
    }
  }
}
</style>
