using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Capstone.Models;
using Capstone.Exceptions;

namespace Capstone.DAO
{
    public class PostDao : IPostDao
    {
        private readonly string connectionString;

        public PostDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public Post GetPostById(int id)
        {
            Post post = new();

            string query = "SELECT post_id, title, content, upvotes, downvotes, date_posted, image_path " +
            "FROM Posts " +
            "WHERE post_id = @Id";

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        post = new Post
                        {
                            PostID = Convert.ToInt32(reader["post_id"]),
                            Title = reader["title"].ToString(),
                            Content = reader["content"].ToString(),
                            UpVotes = Convert.ToInt32(reader["upvotes"]),
                            DownVotes = Convert.ToInt32(reader["downvotes"]),
                            DatePosted = Convert.ToDateTime(reader["date_posted"]),
                            ImagePath = reader["image_path"].ToString()
                        };
                    }
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("SQL exception occurred", e);
            }

            return post;
        }

        public List<Post> GetAllPosts()
        {
            List<Post> postList = new List<Post>();

            string query = "SELECT post_id, title, content, upvotes, downvotes, date_posted, image_path " +
            "FROM Posts";

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Post post = new Post
                        {
                            PostID = Convert.ToInt32(reader["post_id"]),
                            Title = reader["title"].ToString(),
                            Content = reader["content"].ToString(),
                            UpVotes = Convert.ToInt32(reader["upvotes"]),
                            DownVotes = Convert.ToInt32(reader["downvotes"]),
                            DatePosted = Convert.ToDateTime(reader["date_posted"]),
                            ImagePath = reader["image_path"].ToString()
                        };

                        postList.Add(post);
                    }
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("SQL exception occurred", e);
            }

            return postList;
        }

        public Post CreatePost(Post post)
        {
            string query = "INSERT INTO Posts (title, content, date_posted, image_path) " +
                           "VALUES (@Title, @Content, @DatePosted, @ImagePath); " +
                           "SELECT SCOPE_IDENTITY();";

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Title", post.Title);
                    cmd.Parameters.AddWithValue("@Content", post.Content);
                    cmd.Parameters.AddWithValue("@DatePosted", post.DatePosted);
                    cmd.Parameters.AddWithValue("@ImagePath", post.ImagePath);

                    int newPostId = Convert.ToInt32(cmd.ExecuteScalar());

                    post.PostID = newPostId;
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("SQL exception occurred", e);
            }

            return post;
        }

        public Post UpdatePost(Post post)
        {
            string query = "UPDATE Posts " +
                           "SET title = @Title, content = @Content, image_path = @ImagePath " +
                           "WHERE post_id = @Id";

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Title", post.Title);
                    cmd.Parameters.AddWithValue("@Content", post.Content);
                    cmd.Parameters.AddWithValue("@Id", post.PostID);
                    cmd.Parameters.AddWithValue("@ImagePath", post.ImagePath);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        throw new DaoException("Update failed: Post not found");
                    }
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("SQL exception occurred", e);
            }

            return post;
        }

        public Post DeletePost(int id)
        {
            string query = "DELETE FROM Posts WHERE post_id = @Id";
            Post deletedPost = null;

            try
            {
                deletedPost = GetPostById(id);

                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Id", id);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        throw new DaoException("Deletion failed: Post not found");
                    }
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("SQL exception occurred", e);
            }

            return deletedPost;
        }

        public List<Post> GetPostsByForumId(int id)
        {
            throw new NotImplementedException();
        }
    }
}