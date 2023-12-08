using System;
using System.ComponentModel.DataAnnotations;
using System.Runtime.InteropServices;

namespace Capstone.Models
{
    public class Comment
{
    // Primary key of comment
    public int CommentID { get; set; }

    // ID of the user who posted the comment
    public int UserID { get; set; }

    // ID of the post to which the comment belongs
    public int PostID { get; set; }

    // Content of the comment, should be maximum 10 words
    public string CommentContent { get; set; }

    // Number of up votes the comment has received
    public int UpVotes { get; set; }

    // Number of down votes the comment has received
    public int DownVotes { get; set; }

    // Date and time when the comment was created
    public DateTime DateCreated { get; set; }

    // ID of the forum where the post belongs
    public int ForumID { get; set; }
    // ID of the comment being replied to
    public int ParentID { get; set; }
}
}