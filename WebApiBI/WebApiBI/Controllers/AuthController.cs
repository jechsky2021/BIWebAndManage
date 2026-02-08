using DTO;
using DTO.DTOUser;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using System.Collections.Concurrent;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace WebApiBI.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class AuthController : BaseController
    {
        private readonly IConfiguration _config;
        private readonly ILogger<AuthController> _logger;


        public AuthController(IConfiguration config, ILogger<AuthController> logger)
        {
            _config = config;
            _logger = logger;
        }

        //public class LoginRequest
        //{
        //    public string Username { get; set; } = string.Empty;
        //    public string Password { get; set; } = string.Empty;
        //}

        //public class LoginResponse
        //{
        //    public string Token { get; set; } = string.Empty;
        //    public DateTime Expires { get; set; }
        //    public string RefreshToken { get; set; } = string.Empty;
        //}


        public class LoginResponse
        {
            public string Token { get; set; } = string.Empty;
            public DTO_User UserInfo{ get; set; }=new DTO_User();
        }

        public class RefreshRequest
        {
            public string RefreshToken { get; set; } = string.Empty;
        }

        public class RefreshResponse
        {
            public string Token { get; set; } = string.Empty;
            public DateTime Expires { get; set; }
            public string RefreshToken { get; set; } = string.Empty;
        }

        private class RefreshTokenInfo
        {
            public long Uid { get; set; } = 0;
            public DateTime Expires { get; set; }
        }

        // 简单内存存储：key = refreshToken
        private static readonly ConcurrentDictionary<string, RefreshTokenInfo> _refreshTokens
            = new();

        // POST: api/auth/login
        [HttpPost]
        [AllowAnonymous]
        public JsonResult Login([FromBody] DTO_User req)
        {
            _logger.LogInformation("Login attempt for user: {Username}", req.uName);
            DataResult ds = ValidateCredentials(req);

            DTO_User user = JsonConvert.DeserializeObject<List<DTO_User>>(ds.data.ToString() ?? "")?.FirstOrDefault() ?? new DTO_User();

            if (user.id > 0)
            {
                var (tokenString, expires) = GenerateJwtToken(user.id);

                var refreshToken = GenerateRefreshTokenString();
                var refreshExpireDays = int.TryParse(_config["Jwt:RefreshExpireDays"], out var d) ? d : 7;
                SaveRefreshToken(refreshToken, req.id, DateTime.UtcNow.AddDays(refreshExpireDays));

                //return Ok(new LoginResponse
                //{
                //    Token = tokenString,
                //    Expires = expires,
                //    RefreshToken = refreshToken
                //});
                DataResult loginResponse = new DataResult
                {
                    sign = ds.sign,
                    data = new LoginResponse() { Token = tokenString, UserInfo = user },
                    msg = ds.msg
                };
                return Json(loginResponse);
            }
            else
            {
                DataResult loginResponse = new DataResult
                {
                    sign = "0",
                    data = "",
                    msg = "没有此用户！"
                };
                return Json(loginResponse);
            }
        }

        // POST: api/auth/refresh
        [HttpPost]
        [AllowAnonymous]
        public ActionResult<RefreshResponse> Refresh([FromBody] RefreshRequest req)
        {
            if (string.IsNullOrWhiteSpace(req.RefreshToken))
                return BadRequest();

            if (!_refreshTokens.TryGetValue(req.RefreshToken, out var info))
                return Unauthorized();

            if (info.Expires < DateTime.UtcNow)
            {
                // 已过期，移除
                _refreshTokens.TryRemove(req.RefreshToken, out _);
                return Unauthorized();
            }

            // 生成新的 access token，并进行刷新令牌轮换（可选）
            var (newToken, newExpires) = GenerateJwtToken(info.Uid);

            // 轮换 refresh token：删除旧的，生成新的并保存
            _refreshTokens.TryRemove(req.RefreshToken, out _);
            var newRefreshToken = GenerateRefreshTokenString();
            var refreshExpireDays = int.TryParse(_config["Jwt:RefreshExpireDays"], out var d) ? d : 7;
            SaveRefreshToken(newRefreshToken, info.Uid, DateTime.UtcNow.AddDays(refreshExpireDays));

            return Ok(new RefreshResponse
            {
                Token = newToken,
                Expires = newExpires,
                RefreshToken = newRefreshToken
            });
        }

        // POST: api/auth/revoke
        // 撤销当前用户的所有 refresh tokens（需认证）
        [HttpPost]
        [Authorize]
        public IActionResult Revoke()
        {
            var uid = User.FindFirstValue(JwtRegisteredClaimNames.Sub);
            if (string.IsNullOrEmpty(uid))
                return BadRequest();

            foreach (var kv in _refreshTokens)
            {
                if (kv.Value.Uid.ToString() == uid.ToString())
                {
                    _refreshTokens.TryRemove(kv.Key, out _);
                }
            }

            return NoContent();
        }

        private DataResult ValidateCredentials(DTO_User dTO_User)
        {
            DataResult ds = userBaseService.login(dTO_User);
            return ds;
        }

        private (string tokenString, DateTime expires) GenerateJwtToken(long id)
        {
            var jwtKey = _config["Jwt:Key"] ?? "YourSuperSecretKeyHere-ChangeThis";
            var jwtIssuer = _config["Jwt:Issuer"] ?? "yourapp";
            var expireMinutes = int.TryParse(_config["Jwt:ExpireMinutes"], out var m) ? m : 60;

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var expires = DateTime.UtcNow.AddMinutes(expireMinutes);

            var claims = new[]
            {
                new Claim(JwtRegisteredClaimNames.Sub, id.ToString()),
                new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                new Claim("role", "User"),
                new Claim("uid", id.ToString())
            };

            var token = new JwtSecurityToken(
                issuer: jwtIssuer,
                audience: null,
                claims: claims,
                expires: expires,
                signingCredentials: creds
            );

            var tokenString = new JwtSecurityTokenHandler().WriteToken(token);
            return (tokenString, expires);
        }

        private string GenerateRefreshTokenString()
        {
            // 使用安全随机数
            var randomNumber = new byte[64];
            using var rng = RandomNumberGenerator.Create();
            rng.GetBytes(randomNumber);
            return Convert.ToBase64String(randomNumber);
        }

        private void SaveRefreshToken(string refreshToken, long uid, DateTime expires)
        {
            var info = new RefreshTokenInfo
            {
                Uid = uid,
                Expires = expires
            };
            _refreshTokens[refreshToken] = info;
        }
    }
}
