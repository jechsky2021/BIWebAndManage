import CryptoJS from 'crypto-js'

const AES_KEY = '1234567890123456'; // 16位密钥
const AES_IV = '1234567890123456'; // 16位初始化向量

// AES加密函数 (ECB模式)
export const aesEncrypt = (text: string): string => {
  // 将密钥转换为WordArray，确保长度为16位
  const secretKey = CryptoJS.enc.Utf8.parse(AES_KEY.padEnd(16, '0').slice(0, 16))
  
  const encrypted = CryptoJS.AES.encrypt(text, secretKey, {
    mode: CryptoJS.mode.ECB,
    padding: CryptoJS.pad.Pkcs7
  })
  
  return encrypted.toString()
}

// AES解密函数 (ECB模式)
export const aesDecrypt = (ciphertext: string): string => {
  // 将密钥转换为WordArray，确保长度为16位
  const secretKey = CryptoJS.enc.Utf8.parse(AES_KEY.padEnd(16, '0').slice(0, 16))
  
  const decrypted = CryptoJS.AES.decrypt(ciphertext, secretKey, {
    mode: CryptoJS.mode.ECB,
    padding: CryptoJS.pad.Pkcs7
  })
  
  return decrypted.toString(CryptoJS.enc.Utf8)
}

// AES加密函数 (CBC模式)
export const aesCbcEncrypt = (text: string): string => {
  // 将密钥和IV转换为WordArray，确保长度为16位
  const secretKey = CryptoJS.enc.Utf8.parse(AES_KEY.padEnd(16, '0').slice(0, 16))
  const iv = CryptoJS.enc.Utf8.parse(AES_IV.padEnd(16, '0').slice(0, 16))
  
  const encrypted = CryptoJS.AES.encrypt(text, secretKey, {
    iv: iv,
    mode: CryptoJS.mode.CBC,
    padding: CryptoJS.pad.Pkcs7
  })
  
  return encrypted.toString()
}

// AES解密函数 (CBC模式)
export const aesCbcDecrypt = (ciphertext: string): string => {
  // 将密钥和IV转换为WordArray，确保长度为16位
  const secretKey = CryptoJS.enc.Utf8.parse(AES_KEY.padEnd(16, '0').slice(0, 16))
  const iv = CryptoJS.enc.Utf8.parse(AES_IV.padEnd(16, '0').slice(0, 16))
  
  const decrypted = CryptoJS.AES.decrypt(ciphertext, secretKey, {
    iv: iv,
    mode: CryptoJS.mode.CBC,
    padding: CryptoJS.pad.Pkcs7
  })
  
  return decrypted.toString(CryptoJS.enc.Utf8)
}
