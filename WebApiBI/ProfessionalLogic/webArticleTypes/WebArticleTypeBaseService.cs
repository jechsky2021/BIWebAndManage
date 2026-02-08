using DataAccess;
using DTO;
using DTO.Article;
using DTO.WebArticle;
using DTO.WebArticleType;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;

namespace ProfessionalLogic.webArticleTypes
{
    public class WebArticleTypeBaseService : BaseService, IWebArticleTypeBaseService
    {
        public WebArticleTypeBaseService(ILogger<BaseService> logger) : base(logger)
        {
        }

        public DataResult getWebArticleTypeByPage(DTO_WebArticleType model)
        {
            DataSet result = DataHandler.QueryDataSet<DTO_WebArticleType>(model, ProcName.proc_selectWebARTByPage, OpBase.beautyindustry);
            return SelectByPage<DTO_WebArticleType>(result);
        }

    }
}
