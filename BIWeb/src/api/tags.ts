import axios from '../utils/axios';

// 添加评论

export async function addTag(params: { name: string; description?: string }): Promise<any> {
  return axios.post('/webtag/addTag', params);
}

export async function getAllTags(): Promise<any> {
  return axios.post('/webtag/getAllTags');
}

export async function getTagsByPage(params: any): Promise<any> {
  return axios.post('/webtag/getTagsByPage', params);
}

export async function getTagById(params: any): Promise<any> {
  return axios.post('/webtag/getTagById', params);
}

export async function getTagByName(params: any): Promise<any> {
  return axios.post('/webtag/getTagByName', params);
}

export async function updateTag(params: { id: number; name: string; description?: string }): Promise<any> {
  return axios.post('/webtag/updateTag', params);
}

export async function deleteTag(params: any): Promise<any> {
  return axios.post('/webtag/deleteTag', params);
}

