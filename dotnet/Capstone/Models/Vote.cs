using System;


namespace Capstone.Models
{
    public class Vote
    {
        // Primary key of comment or post
        public int TargetID { get; set; }

        // ID of the user who posted the comment
        public int UserID { get; set; }

        // Value of the vote limited to +1/-1
        public int Increment { get; set; }
    }
    public class ReturnVotes 
    {
        // Primary key of comment or post
        public int TargetID { get; set; }
        // Sum of all upvotes
        public int Upvotes { get; set; }
        //Sum of all downvotes
        public int Downvotes { get; set; }
    }
}