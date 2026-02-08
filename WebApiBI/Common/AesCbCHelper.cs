using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace Common
{
    /// <summary>
    /// 简单的 AES-CBC 加解密帮助类（UTF-8 文本，PKCS7 填充）。
    /// 密钥需为 16/24/32 字节（128/192/256 位）。
    /// 输出为 Base64 编码的密文与 IV。
    /// </summary>
    public static class AesCbCHelper
    {
        public sealed record AesResult(string CipherTextBase64, string IvBase64);

        /// <summary>
        /// 使用二进制密钥加密文本，返回 Base64 密文和 IV（Base64）。
        /// </summary>
        public static AesResult Encrypt(string plainText, byte[] key)
        {
            if (plainText is null) throw new ArgumentNullException(nameof(plainText));
            ValidateKey(key);

            using var aes = Aes.Create();
            aes.Mode = CipherMode.CBC;
            aes.Padding = PaddingMode.PKCS7;
            aes.Key = key;
            aes.GenerateIV();
            var iv = aes.IV;

            using var encryptor = aes.CreateEncryptor(aes.Key, iv);
            using var ms = new MemoryStream();
            using (var cs = new CryptoStream(ms, encryptor, CryptoStreamMode.Write))
            {
                var plainBytes = Encoding.UTF8.GetBytes(plainText);
                cs.Write(plainBytes, 0, plainBytes.Length);
                cs.FlushFinalBlock();
            }

            var cipherBytes = ms.ToArray();
            return new AesResult(Convert.ToBase64String(cipherBytes), Convert.ToBase64String(iv));
        }

        /// <summary>
        /// 使用 Base64 密钥（表示原始字节）加密文本，返回 Base64 密文与 IV（Base64）。
        /// </summary>
        public static AesResult Encrypt(string plainText, string keyBase64)
        {
            if (keyBase64 is null) throw new ArgumentNullException(nameof(keyBase64));
            var key = Convert.FromBase64String(keyBase64);
            return Encrypt(plainText, key);
        }

        /// <summary>
        /// 使用二进制密钥和 Base64 IV 解密 Base64 密文，返回原始文本。
        /// </summary>
        public static string Decrypt(string cipherTextBase64, byte[] key, string ivBase64)
        {
            if (cipherTextBase64 is null) throw new ArgumentNullException(nameof(cipherTextBase64));
            if (ivBase64 is null) throw new ArgumentNullException(nameof(ivBase64));
            ValidateKey(key);

            var cipherBytes = Convert.FromBase64String(cipherTextBase64);
            var iv = Convert.FromBase64String(ivBase64);

            using var aes = Aes.Create();
            aes.Mode = CipherMode.CBC;
            aes.Padding = PaddingMode.PKCS7;
            aes.Key = key;
            aes.IV = iv;

            using var decryptor = aes.CreateDecryptor(aes.Key, aes.IV);
            using var ms = new MemoryStream(cipherBytes);
            using var cs = new CryptoStream(ms, decryptor, CryptoStreamMode.Read);
            using var sr = new StreamReader(cs, Encoding.UTF8);
            return sr.ReadToEnd();
        }

        /// <summary>
        /// 使用 Base64 密钥和 Base64 IV 解密 Base64 密文，返回原始文本。
        /// </summary>
        public static string Decrypt(string cipherTextBase64, string keyBase64, string ivBase64)
        {
            if (keyBase64 is null) throw new ArgumentNullException(nameof(keyBase64));
            var key = Convert.FromBase64String(keyBase64);
            return Decrypt(cipherTextBase64, key, ivBase64);
        }

        /// <summary>
        /// 生成安全随机的密钥，长度可选：16/24/32 字节。
        /// 返回 Base64 表示。
        /// </summary>
        public static string GenerateKeyBase64(int sizeInBytes = 32)
        {
            if (sizeInBytes != 16 && sizeInBytes != 24 && sizeInBytes != 32)
                throw new ArgumentException("Key size must be 16, 24 or 32 bytes.", nameof(sizeInBytes));

            var key = new byte[sizeInBytes];
            using var rng = RandomNumberGenerator.Create();
            rng.GetBytes(key);
            return Convert.ToBase64String(key);
        }

        private static void ValidateKey(byte[] key)
        {
            if (key is null) throw new ArgumentNullException(nameof(key));
            if (key.Length != 16 && key.Length != 24 && key.Length != 32)
                throw new ArgumentException("Key length must be 16, 24 or 32 bytes (128/192/256 bits).", nameof(key));
        }
    }
}