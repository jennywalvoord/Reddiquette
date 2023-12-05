using System.Collections.Generic;
using Capstone.Models;

namespace Capstone.DAO
{
    public interface IForumDao
    {
        Forum FindForumByID(int id);
        List<Forum> GetAllForums();
        Forum CreateForum(Forum forum);
        Forum UpdateForum(Forum forum);
        Forum DeleteForum(int id);
    }
}