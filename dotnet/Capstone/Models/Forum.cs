using System;
using System.ComponentModel.DataAnnotations;

namespace Capstone.Models
{
    public class Forum
    {
        // Primary key
        public int ForumId { get; set; }

        // Required field, ErrorMessage is defined here
        [Required(ErrorMessage = "Forum title is required.")]
        public string ForumTitle { get; set; }

        // Required field, ErrorMessage is defined here
        [Required(ErrorMessage = "Forum description is required.")]
        public string ForumDescription { get; set; }

        // Optional field, contains image path
        public string ImagePath { get; set; }

        // Required field, ErrorMessage is defined here
        [Required(ErrorMessage = "Date created is required.")]
        public DateTime DateCreated { get; set; }
    }
}