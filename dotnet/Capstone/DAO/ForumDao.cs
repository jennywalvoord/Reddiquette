using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Capstone.Models;
using Capstone.Exceptions;

namespace Capstone.DAO
{
    public class ForumDao : IForumDao
    {
        private readonly string connectionString;

        public ForumDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public Forum FindForumByID(int id)
        {
            Forum forum = new();

            string query = "SELECT forum_id, forum_title, forum_description, image_path, date_created " +
            "FROM Forums " +
            "WHERE forum_id = @Id";

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
                        forum = new Forum
                        {
                            ForumId = Convert.ToInt32(reader["forum_id"]),
                            ForumTitle = reader["forum_title"].ToString(),
                            ForumDescription = reader["forum_description"].ToString(),
                            ImagePath = reader["image_path"].ToString(),
                            DateCreated = Convert.ToDateTime(reader["date_created"])
                        };
                    }
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("SQL exception occurred", e);
            }
            return forum;
        }

        public List<Forum> GetAllForums()
        {
            List<Forum> forumList = new List<Forum>();

            string query = "SELECT forum_id, forum_title, forum_description, image_path, date_created " +
            "FROM Forums";
            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Forum forum = new Forum
                        {
                            ForumId = Convert.ToInt32(reader["forum_id"]),
                            ForumTitle = reader["forum_title"].ToString(),
                            ForumDescription = reader["forum_description"].ToString(),
                            ImagePath = reader["image_path"].ToString(),
                            DateCreated = Convert.ToDateTime(reader["date_created"])
                        };

                        forumList.Add(forum);
                    }
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("SQL exception occurred", e);
            }
            return forumList;
        }

        public Forum CreateForum(Forum forum)
        {
            string query = "INSERT INTO Forums (forum_title, forum_description, image_path, date_created) " +
                   "VALUES (@Title, @Description, @ImagePath, @DateCreated); " +
                   "SELECT SCOPE_IDENTITY();";

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Title", forum.ForumTitle);
                    cmd.Parameters.AddWithValue("@Description", forum.ForumDescription);
                    cmd.Parameters.AddWithValue("@ImagePath", forum.ImagePath);
                    cmd.Parameters.AddWithValue("@DateCreated", forum.DateCreated);

                    int newForumId = Convert.ToInt32(cmd.ExecuteScalar());

                    forum.ForumId = newForumId;
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("SQL exception occurred", e);
            }

            return forum;
        }

        public Forum UpdateForum(Forum forum)
        {
            string query = "UPDATE Forums " +
                           "SET forum_title = @Title, forum_description = @Description, image_path = @ImagePath " +
                           "WHERE forum_id = @Id";

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Title", forum.ForumTitle);
                    cmd.Parameters.AddWithValue("@Description", forum.ForumDescription);
                    cmd.Parameters.AddWithValue("@ImagePath", forum.ImagePath);
                    cmd.Parameters.AddWithValue("@Id", forum.ForumId);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        throw new DaoException("Update failed: Forum not found");
                    }
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("SQL exception occurred", e);
            }

            return forum;
        }

        public Forum DeleteForum(int id)
        {
            string query = "DELETE FROM Forums WHERE forum_id = @Id";
            Forum deletedForum = null;

            try
            {
                deletedForum = FindForumByID(id);

                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Id", id);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        throw new DaoException("Deletion failed: Forum not found");
                    }
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("SQL exception occurred", e);
            }

            return deletedForum;
        }
    }
}
