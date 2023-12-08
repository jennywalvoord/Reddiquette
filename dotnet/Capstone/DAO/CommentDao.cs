using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Capstone.Models;
using Capstone.Exceptions;

namespace Capstone.DAO
{
    public class CommentDao : ICommentDao
    {
        private readonly string connectionString;
        // Initializes a new instance of the PostDao class.
        // 
        // Parameters:
        //   dbConnectionString: The connection string for the database.
        public CommentDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }
        
        // Retrieves all posts from the database.
        //
        // Returns a list of Post objects representing the retrieved posts.
        public List<Comment> GetAllComments()
        {
            List<Comment> commentList = new List<Comment>();

            string query = "SELECT comment_id, post_id, content, upvotes, downvotes, date_commented " +
                    "FROM Comments";
            
            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Comment comment = new Comment
                        {
                            CommentID = Convert.ToInt32(reader["comment_id"]),
                            PostID = Convert.ToInt32(reader["post_id"]),
                            UserID = Convert.ToInt32(reader["user_id"]),
                            CommentContent = reader["comment_content"].ToString(),
                            UpVotes = Convert.ToInt32(reader["upvotes"]),
                            DownVotes = Convert.ToInt32(reader["downvotes"]),
                            DateCreated = Convert.ToDateTime(reader["date_commented"]),
                            ForumID = Convert.ToInt32(reader["forum_id"]),
                            ParentID = Convert.ToInt32(reader["parent_id"])
                        };

                        commentList.Add(comment);
                    }
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("Failed to retrieve comments", e);
            }

            return commentList;
        }

        public Comment GetCommentById(int id)
        {
            throw new NotImplementedException();
        }

        public List<Comment> GetCommentsByPostId(int id)
        {
            throw new NotImplementedException();
        }

        public Comment CreateComment(Comment comment)
        {
            throw new NotImplementedException();
        }

        public Comment UpdateComment(Comment comment)
        {
            throw new NotImplementedException();
        }
        public Comment DeleteComment(int id)
        {
            throw new NotImplementedException();
        }
    }
    
}