using Capstone.Exceptions;
using Capstone.Models;
using Microsoft.Extensions.Hosting;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Capstone.DAO
{
    public class VotesDao : IVotesDao
    {
        private readonly string connectionString;

        public VotesDao(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public ReturnVotes GetAllPostVotesById(int targetID)
        {
            ReturnVotes votes = new ReturnVotes() { TargetID = targetID, Upvotes = 0, Downvotes = 0 };
            IList<Vote> votesList = new List<Vote>();
           

            string query = "SELECT * FROM post_votes WHERE target_id = @postId";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("postId", targetID);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Vote vote = MapRowToVote(reader);
                        votesList.Add(vote);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            foreach (Vote vote in votesList)
            {
                if (vote.Increment == 1)
                {
                    votes.Upvotes += 1;
                }
                if(vote.Increment == -1)
                {
                    votes.Downvotes += 1;
                }
            }

            return votes;
        }

        public Vote GetPostVoteById(int userId, int postId)
        {
            Vote vote = null;
            string sql = "SELECT * FROM post_votes WHERE user_id = @userId AND target_id = @targetId";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@userId", userId);
                    cmd.Parameters.AddWithValue("@targetId", postId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        vote = MapRowToVote(reader);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }

            return vote;
        }

        public ReturnVotes GetAllCommentVotesById(int targetID)
        {
            ReturnVotes votes = new ReturnVotes() { TargetID = targetID, Upvotes = 0, Downvotes = 0 };
            IList<Vote> votesList = new List<Vote>();
         
            string query = "SELECT * FROM comment_votes WHERE target_id = @commentId";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("commentId", targetID);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Vote vote = MapRowToVote(reader);
                        votesList.Add(vote);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            foreach (Vote vote in votesList)
            {
                if (vote.Increment == 1)
                {
                    votes.Upvotes += 1;
                }
                if (vote.Increment == -1)
                {
                    votes.Downvotes += 1;
                }
            }

            return votes;
        }

        public Vote GetCommentVoteById(int userId, int commentId)
        {
            Vote vote = null;
            string sql = "SELECT * FROM comment_votes WHERE user_id = @userId AND target_id = @targetId";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@userId", userId);
                    cmd.Parameters.AddWithValue("@targetId", commentId);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        vote = MapRowToVote(reader);
                    }
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }

            return vote;
        }

        public Vote CreatePostVote(int userId, int targetID, int increment)
        {
            Vote vote = null;

            string sql = "INSERT INTO post_votes(user_id, target_id, inc) " +
                "VALUES (@userId, @targetId, @inc)";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@userId", userId);
                    cmd.Parameters.AddWithValue("@targetId", targetID);
                    cmd.Parameters.AddWithValue("@inc", increment);

                    cmd.ExecuteNonQuery();

                    vote = GetPostVoteById(userId, targetID);

                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return vote;
        }

        public Vote CreateCommentVote(int userId, int targetID, int increment)
        {
            Vote vote = null;

            string sql = "INSERT INTO comment_votes(user_id, target_id, inc) " +
                "VALUES (@userId, @targetId, @inc)";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@userId", userId);
                    cmd.Parameters.AddWithValue("@targetId", targetID);
                    cmd.Parameters.AddWithValue("@inc", increment);

                    cmd.ExecuteNonQuery();

                    vote = GetCommentVoteById(userId, targetID);
                }
            }
            catch (SqlException ex)
            {
                throw new DaoException("SQL exception occurred", ex);
            }
            return vote;
        }

        public Vote UpdateCommentVote(int userId, int commentId, int increment)
        {
            Vote vote = null;
            string query = "UPDATE comment_votes " +
                        "SET inc = @Inc " +
                        "WHERE comment_id = @commentId AND user_id = @userId";

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Inc", increment);
                    cmd.Parameters.AddWithValue("@commentId", commentId);
                    cmd.Parameters.AddWithValue("@userId", userId);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        throw new DaoException("Update failed: Vote not found");
                    }
                    vote = GetCommentVoteById(userId, commentId);
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("SQL exception occurred", e);
            }

            return vote;
        }
        public Vote UpdatePostVote(int userId, int postId, int increment)
        {
            Vote vote = null;
            string query = "UPDATE post_votes " +
                        "SET inc = @Inc " +
                        "WHERE post_id = @posttId AND user_id = @userId";

            try
            {
                using (var conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    var cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Inc", increment);
                    cmd.Parameters.AddWithValue("@postId", postId);
                    cmd.Parameters.AddWithValue("@userId", userId);

                    int rowsAffected = cmd.ExecuteNonQuery();
                    if (rowsAffected == 0)
                    {
                        throw new DaoException("Update failed: Vote not found");
                    }
                    vote = GetPostVoteById(userId, postId);
                }
            }
            catch (SqlException e)
            {
                throw new DaoException("SQL exception occurred", e);
            }

            return vote;
        }

        private Vote MapRowToVote(SqlDataReader reader)
        {
            Vote vote = new Vote();
            vote.UserID = Convert.ToInt32(reader["user_id"]);
            vote.TargetID = Convert.ToInt32(reader["target_id"]);
            vote.Increment = Convert.ToInt32(reader["inc"]);
            return vote;
        }
    }
}
