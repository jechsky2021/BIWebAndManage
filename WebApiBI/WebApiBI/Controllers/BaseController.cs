using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ProfessionalLogic;
using ProfessionalLogic.articles;
using ProfessionalLogic.articleTypes;
using ProfessionalLogic.menus;
using ProfessionalLogic.roles;
using ProfessionalLogic.users;
using ProfessionalLogic.WebArticles;
using ProfessionalLogic.webArticleTypes;

namespace WebApiBI.Controllers
{
    [Authorize]
    public class BaseController : Controller
    {

        /// <summary>
        /// 从当前请求的 DI 容器中解析 IUserBaseService。
        /// 延迟解析，避免在 BaseController 构造时必须显式传入参数。
        /// </summary>
        protected IUserBaseService userBaseService =>
            HttpContext?.RequestServices?.GetRequiredService<IUserBaseService>()
            ?? throw new InvalidOperationException("IUserBaseService 未注册或 HttpContext 为 null。请在 Program.cs 中注册服务。");

        protected IMenuBaseService menuBaseService =>
            HttpContext?.RequestServices?.GetRequiredService<IMenuBaseService>()
            ?? throw new InvalidOperationException("IMenuBaseService 未注册或 HttpContext 为 null。请在 Program.cs 中注册服务。");

        protected IRoleBaseService roleBaseService =>
            HttpContext?.RequestServices?.GetRequiredService<IRoleBaseService>()
            ?? throw new InvalidOperationException("IRoleBaseService 未注册或 HttpContext 为 null。请在 Program.cs 中注册服务。");

        protected IArticleBaseService articleBaseService =>
           HttpContext?.RequestServices?.GetRequiredService<IArticleBaseService>()
           ?? throw new InvalidOperationException("IArticleBaseService 未注册或 HttpContext 为 null。请在 Program.cs 中注册服务。");

        protected IArticleTypeBaseService articleTypeBaseService =>
           HttpContext?.RequestServices?.GetRequiredService<IArticleTypeBaseService>()
           ?? throw new InvalidOperationException("IArticleTypeBaseService 未注册或 HttpContext 为 null。请在 Program.cs 中注册服务。");

        protected IWebArticleBaseService webArticleBaseService =>
           HttpContext?.RequestServices?.GetRequiredService<IWebArticleBaseService>()
           ?? throw new InvalidOperationException("IWebArticleBaseService 未注册或 HttpContext 为 null。请在 Program.cs 中注册服务。");

        protected IWebArticleTypeBaseService webArticleTypeBaseService =>
           HttpContext?.RequestServices?.GetRequiredService<IWebArticleTypeBaseService>()
           ?? throw new InvalidOperationException("IWebArticleTypeBaseService 未注册或 HttpContext 为 null。请在 Program.cs 中注册服务。");



    }
}
