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

        // Initializes a new instance of the PostDao class.
        // 
        // Parameters:
        //   dbConnectionString: The connection string for the database.
        public PostDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        // Retrieves a post from the database based on the specified ID.
        //
        // Parameters:
        //     id: The ID of the post to retrieve.
        //
        // Returns: The retrieved Post object.
        public Post GetPostByID(int id)
        {
            Post post = new();

            string query = "SELECT post_id, user_id, post_content, up_votes, down_votes, date_created, forum_id " +
                    "FROM posts " +
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
                            UserID = Convert.ToInt32(reader["user_id"]),
                            PostContent = reader["post_content"].ToString(),
                            UpVotes = Convert.ToInt32(reader["up_votes"]),
                            DownVotes = Convert.ToInt32(reader["down_votes"]),
                            DateCreated = Convert.ToDateTime(reader["date_created"]),
                            ForumId = Convert.ToInt32(reader["forum_id"]),
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

        // Retrieves all posts from the database.
        //
        // Returns a list of Post objects representing the retrieved posts.
        public List<Post> GetAllPosts()
        {
            List<Post> postList = new List<Post>();

            string query = "SELECT p.post_id, p.user_id, p.post_content, p.up_votes, p.down_votes, p.date_created, p.forum_id, f.forum_title " +
                    "FROM posts AS p " +
                    "JOIN forum AS f ON p.forum_id = f.forum_id";

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
                            UserID = Convert.ToInt32(reader["user_id"]),
                            PostContent = reader["post_content"].ToString(),
                            UpVotes = Convert.ToInt32(reader["up_votes"]),
                            DownVotes = Convert.ToInt32(reader["down_votes"]),
                            DateCreated = Convert.ToDateTime(reader["date_created"]),
                            ForumId = Convert.ToInt32(reader["forum_id"]),
                            //ForumTitle = reader["forum_title"].ToString()
                            
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
        
        // Retrieves a list of posts based on the specified forum ID.
        // 
        // Parameters:
        //   id: The ID of the forum.
        //
        // Returns: A list of Post objects.
        public List<Post> GetPostsByForumId(int id)
        {
            List<Post> postList = new List<Post>();

            string query = "SELECT p.post_id, p.user_id , p.post_content, p.up_votes, p.down_votes, p.date_created, p.forum_id, f.forum_title " +
                        "FROM posts AS p " +
                        "JOIN forum AS f ON p.forum_id = f.forum_id " +
                        "WHERE p.forum_id = @Id";

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Id", id);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Post post = new Post
                        {
                            PostID = Convert.ToInt32(reader["post_id"]),
                            UserID = Convert.ToInt32(reader["user_id"]),
                            PostContent = reader["post_content"].ToString(),
                            UpVotes = Convert.ToInt32(reader["up_votes"]),
                            DownVotes = Convert.ToInt32(reader["down_votes"]),
                            DateCreated = Convert.ToDateTime(reader["date_created"]),
                            ForumId = Convert.ToInt32(reader["forum_id"]),
                            //ForumTitle = reader["forum_title"].ToString()
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

        // Creates a new post in the database.
        //
        // Parameters:
        //   post: The post object containing the data to be inserted.
        //
        // Returns: The newly created post with the updated PostID.
        public Post CreatePost(Post post)
        {
            string query = "INSERT INTO posts (user_id, post_content, up_votes, down_votes, date_created, forum_id) " +
                        "VALUES (@UserID, @PostContent, @UpVotes, @DownVotes, @DateCreated, @ForumID); " +
                        "SELECT SCOPE_IDENTITY();";

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    
                    cmd.Parameters.AddWithValue("@UserID", post.UserID);
                    cmd.Parameters.AddWithValue("@UpVotes", post.UpVotes);
                    cmd.Parameters.AddWithValue("@DownVotes", post.DownVotes);
                    cmd.Parameters.AddWithValue("@PostContent", post.PostContent);
                    cmd.Parameters.AddWithValue("@DateCreated", post.DateCreated);
                    cmd.Parameters.AddWithValue("@ForumID", post.ForumId);

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

        // Updates a post in the database.
        //
        // Parameters:
        //   post: The post object containing the updated information.
        //
        // Returns: The updated post object.
        public Post UpdatePost(Post post)
        {
            string query = "UPDATE posts " +
                        "SET user_id = @UserID, post_content = @PostContent, date_created = @DateCreated, forum_id = @ForumID " +
                        "WHERE post_id = @Id";

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@UserID", post.UserID);
                    cmd.Parameters.AddWithValue("@PostContent", post.PostContent);
                    cmd.Parameters.AddWithValue("@DateCreated", post.DateCreated);
                    cmd.Parameters.AddWithValue("@ForumID", post.ForumId);
                    cmd.Parameters.AddWithValue("@Id", post.PostID);

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

        // Deletes a post with the given ID from the database.
        //
        // Parameters:
        //   id: The ID of the post to be deleted.
        //
        // Returns: The deleted post.
        public Post DeletePost(int id)
        {
            string query = "DELETE " +
                        "FROM posts " +
                        "WHERE post_id = @Id";
            Post deletedPost = null;

            try
            {
                deletedPost = GetPostByID(id);

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
    }
}