import axios from '../utils/axios';

// 获取文章列表
export async function getArticlesByPage(params: any): Promise<any> {
  return axios.post('/WebArticle/GetLastByPage', params);
}

// 获取文章详情
export async function getArticlesById(params: any): Promise<any> {
  return axios.post('/WebArticle/GetDetailById', params);
}

// 搜索网站
export async function getSearchArticles(params: any): Promise<any> {
  return axios.post('/WebArticle/GetSearchArticles', params);
}

