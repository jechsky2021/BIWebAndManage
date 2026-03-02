using DTO;
using DTO.DTO_WebUserTopicLike;
using DTO.DTOTopics;

namespace ProfessionalLogic.topics
{
    public interface IWebTopicsBaseService
    {
        DataResult addTopics(DTO_Topic model);
        DataResult getTopicsByPage(DTO_Page model);
        DataResult getTopicById(DTO_Id model);
        DataResult updateTopicPageViews(DTO_Id model);
        DataResult updateTopicLikes(DTO_UidTid model);
        DataResult getUidTid(DTO_UidTid model);
        DataResult cancelTopicLikes(DTO_UidTid model);
        DataResult getMyTopics(DTO_UidPage model);
        DataResult getMyLikes(DTO_UidPage model);
    }
}
