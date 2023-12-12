using Capstone.Models;
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

        public ReturnVotes GetPostVotesById(int targetID)
        {
            ReturnVotes votes = null;
            IList<Vote> votesList = new List<Vote>();
            int upCount = 0;
            int downCount = 0;

            string query = "SELECT * FROM post_votes WHERE post_id = @postId";

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("postId", targetID);
                    SqlDataReader reader = cmd.ExecuteReader();
                }
            }


            return votes;
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
