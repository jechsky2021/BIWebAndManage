using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using ProfessionalLogic;
using ProfessionalLogic.answers;
using ProfessionalLogic.articles;
using ProfessionalLogic.articleTypes;
using ProfessionalLogic.comments;
using ProfessionalLogic.menus;
using ProfessionalLogic.questions;
using ProfessionalLogic.roles;
using ProfessionalLogic.tags;
using ProfessionalLogic.topics;
using ProfessionalLogic.users;
using ProfessionalLogic.WebArticles;
using ProfessionalLogic.webArticleTypes;
using ProfessionalLogic.webUsers;
using Serilog;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// 从配置初始化 Serilog（appsettings.json 中配置 Serilog）
Log.Logger = new LoggerConfiguration()
    .ReadFrom.Configuration(builder.Configuration)
    .Enrich.FromLogContext()
    .CreateLogger();

builder.Host.UseSerilog();


var jwtKey = builder.Configuration["Jwt:Key"] ?? "YourSuperSecretKeyHere-ChangeThis";
var jwtIssuer = builder.Configuration["Jwt:Issuer"] ?? "yourapp";

// Add services
builder.Services.AddControllers();

// 注册业务层到 DI，使其能注入 ILogger<T>
builder.Services.AddScoped<BaseService>();

builder.Services.AddScoped<IUserBaseService, UserBaseService>();
builder.Services.AddScoped<IMenuBaseService, MenuBaseService>();
builder.Services.AddScoped<IRoleBaseService, RoleBaseService>();
builder.Services.AddScoped<IArticleBaseService, ArticleBaseService>();
builder.Services.AddScoped<IArticleTypeBaseService, ArticleTypeBaseService>();
builder.Services.AddScoped<IWebArticleBaseService, WebArticleBaseService>();
builder.Services.AddScoped<IWebArticleTypeBaseService, WebArticleTypeBaseService>();
builder.Services.AddScoped<IWebUserBaseService, WebUserBaseService>();
builder.Services.AddScoped<IWebTopicsBaseService, WebTopicsBaseService>();
builder.Services.AddScoped<IWebCommentsBaseService, WebCommentsBaseService>();
builder.Services.AddScoped<IWebQuestionsBaseService, WebQuestionsBaseService>();
builder.Services.AddScoped<IWebAnswersBaseService, WebAnswersBaseService>();
builder.Services.AddScoped<IWebTagsBaseService, WebTagsBaseService>();


// 配置CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAllOrigins", builder =>
    {
        builder.AllowAnyOrigin()
               .AllowAnyMethod()
               .AllowAnyHeader();
    });
});

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.RequireHttpsMetadata = false; // 开发环境中允许HTTP访问
        options.SaveToken = true;
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidIssuer = jwtIssuer,
            ValidateAudience = false,
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey)),
            //ValidateLifetime = true
            ClockSkew = TimeSpan.Zero // 取消默认的5分钟过期宽限时间
        };
    });

builder.Services.AddAuthorization();

var app = builder.Build();

app.UseHttpsRedirection();

// 启用CORS，注意顺序要在认证之前
app.UseCors("AllowAllOrigins");

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

try
{
    Log.Information("Starting web host");
    app.Run();
}
catch (Exception ex)
{
    Log.Fatal(ex, "Host terminated unexpectedly");
}
finally
{
    Log.CloseAndFlush();
}
