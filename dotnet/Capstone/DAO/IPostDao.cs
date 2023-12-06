using System.Collections.Generic;
using Capstone.Models;

namespace Capstone.DAO
{
    public interface IPostDao
    {
        List<Post> GetAllPosts();
        Post GetPostById(int id);
        List<Post> GetPostsByForumId(int id);
        Post CreatePost(Post post);
        Post UpdatePost(Post post);
        Post DeletePost(int id);
    }
}