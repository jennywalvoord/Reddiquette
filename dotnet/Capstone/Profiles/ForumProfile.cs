using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Capstone.Models;
using Capstone.DTO;

namespace Capstone.Profiles
{
    
    public class ForumProfile : Profile
    {
        // Initializes a new instance of the ForumProfile class.
        public ForumProfile()
        {
            // Maps Post to PostDto and vice versa
            CreateMap<Forum, ForumDto>().ReverseMap();
        }
    }
}