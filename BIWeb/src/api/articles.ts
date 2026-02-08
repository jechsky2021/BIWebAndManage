import axios from '../utils/axios';

// 定义文章相关的类型
interface ArticleParams {
  page?: number;
  pageSize?: number;
  id?: number;
  [key: string]: any;
}

interface Article {
  id: number;
  title: string;
  content: string;
  createdAt: string;
  [key: string]: any;
}

interface ArticleListResponse {
  total: number;
  list: Article[];
  [key: string]: any;
}

interface ArticleDetailResponse {
  article: Article;
  [key: string]: any;
}

// 获取文章列表
export async function getArticlesByPage(params: ArticleParams): Promise<ArticleListResponse> {
  return axios.post('/WebArticle/GetLastByPage', params);
}

// 获取文章详情
export async function getArticlesById(params: ArticleParams): Promise<ArticleDetailResponse> {
  return axios.post('/WebArticle/GetDetailById', params);
}



