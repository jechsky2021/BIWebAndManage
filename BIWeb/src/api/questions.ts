import axios from '../utils/axios';

export async function addQuestion(params: any): Promise<any> {
  return axios.post('/webquestion/addQuestion', params);
}

export async function getQuestionsByPage(params: any): Promise<any> {
  return axios.post('/webquestion/getQuestionsByPage', params);
}

export async function getQuestionDetail(params: any): Promise<any> {
  return axios.post('/webquestion/GetQuestionById', params);
}

export async function UpdateQuestionPageViews(params: any): Promise<any> {
  return axios.post('/webquestion/UpdateQuestionPageViews', params);
}

export async function updateQuestionLikes(params: any): Promise<any> {
  return axios.post('/webquestion/UpdateQuestionLikes', params);
}

export async function getUidQid(params: any): Promise<any> {
  return axios.post('/webquestion/GetUidQid', params);
}

export async function cancelQuestionLikes(params: any): Promise<any> {
  return axios.post('/webquestion/CancelQuestionLikes', params);
}

export async function getMyQuestions(params: any): Promise<any> {
  return axios.post('/webquestion/GetMyQuestionsByPage', params);
}

export async function getMyQuestionLikes(params: any): Promise<any> {
  return axios.post('/webquestion/GetMyQuestionLikesByPage', params);
}


export async function addAnswer(params: any): Promise<any> {
  return axios.post('/WebAnswer/AddAnswer', params);
}

export async function getAnswersByPage(params: any): Promise<any> {
  return axios.post('/WebAnswer/GetAnswersByPage', params);
}

export async function updateAnswerIsAccepted(params: any): Promise<any> {
  return axios.post('/WebAnswer/UpdateAnswerIsAccepted', params);
}

