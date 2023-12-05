using System;
using System.ComponentModel.DataAnnotations;

namespace Capstone.Models
{
    public class Forum
    {
        public int ForumId { get; set; }

        [Required(ErrorMessage = "Forum title is required.")]
        public string ForumTitle { get; set; }

        [Required(ErrorMessage = "Forum description is required.")]
        public string ForumDescription { get; set; }

        public string ImagePath { get; set; }

        [Required(ErrorMessage = "Date created is required.")]
        public DateTime DateCreated { get; set; }
    }
}