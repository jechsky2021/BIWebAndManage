import { fileService } from '../utils/axios'

// 保存图片
export const saveGoodsPic = (params: any): Promise<any> => {
  return fileService.post('/fileManageEndPoint/saveGoodsPic', params)
}

// 查看图片
export const downLoadFromOSS = (params: any): Promise<any> => {
  return fileService.post('/fileManageEndPoint/downLoadFromOSS', params)
}

