using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;

namespace Common
{
    public class AesHelper
    {

        // 固定密钥和IV（与你的JavaScript保持一致）
        private static readonly byte[] AES_KEY = Encoding.UTF8.GetBytes("1234567890123456");
        private static readonly byte[] AES_IV = Encoding.UTF8.GetBytes("1234567890123456");

        /// <summary>
        /// 验证密钥和IV的长度
        /// </summary>
        private static void ValidateKeys()
        {
            if (AES_KEY.Length != 16 && AES_KEY.Length != 24 && AES_KEY.Length != 32)
                throw new ArgumentException("AES密钥长度必须是16、24或32字节");

            if (AES_IV.Length != 16)
                throw new ArgumentException("AES IV长度必须是16字节");
        }

        /// <summary>
        /// AES CBC模式加密（返回Base64字符串）
        /// </summary>
        /// <param name="plainText">明文</param>
        /// <returns>Base64格式的密文</returns>
        public static string Encrypt(string plainText)
        {
            if (string.IsNullOrEmpty(plainText))
                return plainText;

            ValidateKeys();

            using (Aes aes = Aes.Create())
            {
                aes.Key = AES_KEY;
                aes.IV = AES_IV;
                aes.Mode = CipherMode.CBC;
                aes.Padding = PaddingMode.PKCS7;

                ICryptoTransform encryptor = aes.CreateEncryptor(aes.Key, aes.IV);

                using (MemoryStream ms = new MemoryStream())
                using (CryptoStream cs = new CryptoStream(ms, encryptor, CryptoStreamMode.Write))
                {
                    byte[] plainBytes = Encoding.UTF8.GetBytes(plainText);
                    cs.Write(plainBytes, 0, plainBytes.Length);
                    cs.FlushFinalBlock();

                    return Convert.ToBase64String(ms.ToArray());
                }
            }
        }

        /// <summary>
        /// AES CBC模式解密
        /// </summary>
        /// <param name="cipherText">Base64格式的密文</param>
        /// <returns>明文</returns>
        public static string Decrypt(string cipherText)
        {
            if (string.IsNullOrEmpty(cipherText))
                return cipherText;

            ValidateKeys();

            try
            {
                byte[] cipherBytes = Convert.FromBase64String(cipherText);

                using (Aes aes = Aes.Create())
                {
                    aes.Key = AES_KEY;
                    aes.IV = AES_IV;
                    aes.Mode = CipherMode.CBC;
                    aes.Padding = PaddingMode.PKCS7;

                    ICryptoTransform decryptor = aes.CreateDecryptor(aes.Key, aes.IV);

                    using (MemoryStream ms = new MemoryStream(cipherBytes))
                    using (CryptoStream cs = new CryptoStream(ms, decryptor, CryptoStreamMode.Read))
                    using (StreamReader sr = new StreamReader(cs, Encoding.UTF8))
                    {
                        return sr.ReadToEnd();
                    }
                }
            }
            catch (FormatException)
            {
                throw new ArgumentException("密文格式不正确，必须是有效的Base64字符串");
            }
            catch (CryptographicException ex)
            {
                throw new CryptographicException("解密失败，请检查密钥、IV或密文是否正确", ex);
            }
        }

        /// <summary>
        /// AES CBC模式加密（返回十六进制字符串）
        /// </summary>
        public static string EncryptToHex(string plainText)
        {
            string base64 = Encrypt(plainText);
            byte[] bytes = Convert.FromBase64String(base64);
            return BitConverter.ToString(bytes).Replace("-", "").ToLower();
        }

        /// <summary>
        /// AES CBC模式解密（从十六进制字符串）
        /// </summary>
        public static string DecryptFromHex(string hexString)
        {
            if (string.IsNullOrEmpty(hexString))
                return hexString;

            if (hexString.Length % 2 != 0)
                throw new ArgumentException("十六进制字符串长度必须是偶数");

            byte[] bytes = new byte[hexString.Length / 2];
            for (int i = 0; i < bytes.Length; i++)
            {
                string byteValue = hexString.Substring(i * 2, 2);
                bytes[i] = Convert.ToByte(byteValue, 16);
            }

            string base64 = Convert.ToBase64String(bytes);
            return Decrypt(base64);
        }

        /// <summary>
        /// 批量加密字符串数组
        /// </summary>
        public static string[] EncryptArray(string[] plainTexts)
        {
            if (plainTexts == null)
                return null;

            string[] results = new string[plainTexts.Length];
            for (int i = 0; i < plainTexts.Length; i++)
            {
                results[i] = Encrypt(plainTexts[i]);
            }
            return results;
        }

        /// <summary>
        /// 批量解密字符串数组
        /// </summary>
        public static string[] DecryptArray(string[] cipherTexts)
        {
            if (cipherTexts == null)
                return null;

            string[] results = new string[cipherTexts.Length];
            for (int i = 0; i < cipherTexts.Length; i++)
            {
                results[i] = Decrypt(cipherTexts[i]);
            }
            return results;
        }

        /// <summary>
        /// 加密对象为JSON字符串
        /// </summary>
        public static string EncryptObject<T>(T obj)
        {
            if (obj == null)
                return null;

            string json = System.Text.Json.JsonSerializer.Serialize(obj);
            return Encrypt(json);
        }

        /// <summary>
        /// 解密JSON字符串为对象
        /// </summary>
        public static T DecryptObject<T>(string cipherText)
        {
            if (string.IsNullOrEmpty(cipherText))
                return default;

            string json = Decrypt(cipherText);
            return System.Text.Json.JsonSerializer.Deserialize<T>(json);
        }


    }
}
