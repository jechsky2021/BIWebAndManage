using System;
using System.Collections.Generic;
using System.Text;

namespace DataAccess
{
    public class ProcName
    {
        public static readonly string proc_select = "proc_select";

        // 登录
        public static readonly string proc_login = "proc_login";

        #region users

        public static readonly string proc_selectUsersByPage = "proc_selectUsersByPage";
        public static readonly string proc_insertUser = "proc_insertUser";
        public static readonly string proc_updateUser = "proc_updateUser";
        public static readonly string proc_updateUserPWD = "proc_updateUserPWD";
        public static readonly string proc_selectRolesByUid = "proc_selectRolesByUid";
        public static readonly string proc_deleteUserRole = "proc_deleteUserRole";
        public static readonly string proc_selectUserById = "proc_selectUserById";

        #endregion

        #region webusers

        public static readonly string proc_insertWebUser = "proc_insertWebUser";
        public static readonly string proc_loginWeb = "proc_loginWeb";
        public static readonly string proc_selectWebUserById = "proc_selectWebUserById";
        public static readonly string proc_updateWebUser = "proc_updateWebUser";
        public static readonly string proc_updateWebUserAvatar = "proc_updateWebUserAvatar";
        public static readonly string proc_updateWebUserPWD = "proc_updateWebUserPWD";

        #endregion

        #region userrole

        public static readonly string proc_insertUserRole = "proc_insertUserRole";

        #endregion

        #region role

        public static readonly string proc_selectRoleByPage = "proc_selectRoleByPage";
        public static readonly string proc_insertRole = "proc_insertRole";
        public static readonly string proc_updateRole = "proc_updateRole";
        public static readonly string proc_deleteRoleById = "proc_deleteRoleById";
        public static readonly string proc_selectMenuByRoleId = "proc_selectMenuByRoleId";
        public static readonly string proc_deleteRoleMenu = "proc_deleteRoleMenu";

        #endregion

        #region rolemenu

        public static readonly string proc_insertRoleMenu = "proc_insertRoleMenu";

        #endregion

        #region menu

        public static readonly string proc_getMenuByUid = "proc_getMenuByUid";
        public static readonly string proc_selectMenuAll = "proc_selectMenuAll";
        public static readonly string proc_insertMenu = "proc_insertMenu";
        public static readonly string proc_updateMenu = "proc_updateMenu";
        public static readonly string proc_deleteMenuById = "proc_deleteMenuById";

        #endregion

        #region article

        public static readonly string proc_selectArticleByPage = "proc_selectArticleByPage";
        public static readonly string proc_insertArticle = "proc_insertArticle";
        public static readonly string proc_updateArticle = "proc_updateArticle";
        public static readonly string proc_selectArticleById = "proc_selectArticleById";
        public static readonly string proc_updateStatussById = "proc_updateStatussById";
        public static readonly string proc_selectPublishArticleById = "proc_selectPublishArticleById";

        public static readonly string proc_updatePageViews = "proc_updatePageViews";

        public static readonly string proc_selectWebArticleByPage = "proc_selectWebArticleByPage";
        public static readonly string proc_searchArticle = "proc_searchArticle";

        #endregion

        #region articleType

        public static readonly string proc_selectArticleType = "proc_selectArticleType";
        public static readonly string proc_selectArticleTypeByPage = "proc_selectArticleTypeByPage";
        public static readonly string proc_insertArticleType = "proc_insertArticleType";
        public static readonly string proc_updateArticleType = "proc_updateArticleType";
        public static readonly string proc_deleteArticleTypeById = "proc_deleteArticleTypeById";

        public static readonly string proc_selectWebARTByPage = "proc_selectWebArticleTypeByPage";

        #endregion


    }
}
