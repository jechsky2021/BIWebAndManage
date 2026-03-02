import axios from '../utils/axios';

export async function addTopic(params: any): Promise<any> {
  return axios.post('/webtopic/addtopic', params);
}

export async function getTopicsByPage(params: any): Promise<any> {
  return axios.post('/webtopic/gettopicsbypage', params);
}

export async function getTopicDetail(params: any): Promise<any> {
  return axios.post('/webtopic/gettopicbyid', params);
}

export async function getCommentsByPage(params: any): Promise<any> {
  return axios.post('/webcomment/getcommentsbypage', params);
}

export async function addComment(params: any): Promise<any> {
  return axios.post('/webcomment/addcomment', params);
}

export async function updateTopicPageViews(params: any): Promise<any> {
  return axios.post('/webtopic/UpdateTopicPageViews', params);
}

export async function updateTopicLikes(params: any): Promise<any> {
  return axios.post('/webtopic/UpdateTopicLikes', params);
}

export async function getUidTid(params: any): Promise<any> {
  return axios.post('/webtopic/getUidTid', params);
}

export async function cancelTopicLikes(params: any): Promise<any> {
  return axios.post('/webtopic/cancelTopicLikes', params);
}

export async function getMyTopics(params: any): Promise<any> {
  return axios.post('/webtopic/getMyTopics', params);
}

export async function getMyLikes(params: any): Promise<any> {
  return axios.post('/webtopic/getMyLikes', params);
}

