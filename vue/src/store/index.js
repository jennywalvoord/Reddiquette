import { createStore as _createStore } from 'vuex';
import axios from 'axios';
import AuthService from '../services/AuthService';

export function createStore(currentToken, currentUser) {
  let store = _createStore({
  
    state: {
      // comment: [],
      // forums: [],
      token: currentToken || '',
      user: currentUser || {},
      isAuthenticated: !!currentToken,
      forums:[{
        id: 1,
        title: "Tech Enthusiasts Unite",
        description: "Discuss the latest gadgets and innovations!",
        image:'',
        numberOfReplys:0
      },
      {
        id: 2,
        title: "Pop Culture Club",
        description: "Discuss the latest in Pop Culture and related happenings!",
        image:'',
        numberOfReplys:0
      },
      {
        id: 3,
        title: "Creative Minds Hub",
        description: "Share your art, writing, and other passions",
        image:'',
        numberOfReplys:0

      },
      {
        id: 4,
        title: "Fitness Fanatics Forum",
        description: "Achieve your health and wellness goals together.",
        image:'',
        numberOfReplys:0
      },
      {
        id: 5,
        title: "Travel Tales Exchange",
        description: "",
        image:'',
        numberOfReplys:0
      },
      {
        id: 6,
        title: "Global Conflicts Dialogue",
        description: "Navigate discussions on the Israeli-Palestinian conflict and its parallels with the war in Ukraine. Foster understanding and explore potential connections for a world in search of peace.",
        image:'',
        numberOfReplys:0
      },
      {
        id: 7,
        title: "Cleveland Sports Fever",
        description: "Cheer for your favorite teams in the heart of the action!",
        image:'',
        numberOfReplys:0
      },
      {
        id: 8,
        title: "Foodie Haven",
        description: "Explore culinary delights, share recipes, and discuss your favorite dining experiences!",
        image: '',
        numberOfReplies: 0
      },
      {
        id: 9,
        title: "Tech Tips and Tricks",
        description: "Exchange hacks, tips, and tricks for mastering the latest technologies!",
        image: '',
        numberOfReplies: 0
      },
      {
        id: 10,
        title: "Bookworms Corner",
        description: "Dive into the world of literature! Share book recommendations, discuss plots, and connect with fellow book enthusiasts.",
        image: '',
        numberOfReplies: 0
      },
      {
        id: 11,
        title: "Gaming Galore",
        description: "Level up your gaming discussions! From latest releases to all-time classics, join fellow gamers in the ultimate gaming community.",
        image: '',
        numberOfReplies: 0
      },
      {
        id: 12,
        title: "Mindfulness Oasis",
        description: "Embark on a journey of self-discovery. Discuss mindfulness practices, meditation techniques, and wellness strategies.",
        image: '',
        numberOfReplies: 0
      }
      ],
      posts: [{
        userId: 1,
        id: 1,
        forumId: 1,
        
        title: 'C# Better than Java?',
        body: "C# is the supreme Coding Language! But Ultimately, the choice between C# and Java depends on the specific project requirements, the existing tech stack, and the preferences and expertise of the development team. Both languages have strengths and weaknesses, and neither is inherently better than the other in all situations.",
        image: "https://www.bairesdev.com/wp-content/uploads/2021/07/Csharp.svg",
        dateCreated: '12/07/2023',
        clout: 15,
        upVote: 7,
        downVote: 8,
    },
      
      {
        id: 2,
        forumId: 5,
        userId: 1,
        title: 'Travel NE OHIO',
        body: "Embark on a Northeast Ohio Adventure: Discover the hidden gems and vibrant landscapes of the region. From the scenic beauty of Cuyahoga Valley National Park to the cultural delights of Cleveland, explore the diverse experiences waiting for you in Northeast Ohio. Whether you're into outdoor adventures, arts and culture, or culinary delights, this charming corner of the state offers something for every traveler.",
        image: "https://i.gifer.com/9sbb.gif",
        dateCreated: '02/14/2021',
        clout: 10,
        upVote: 23,
        downVote: 13
      },
      {
        id: 3,
        forumId:1,
        userId: 4,
        title: 'Junior Dev Jobs Real?',
        body: "Junior developer positions are very much real and serve as valuable entry points for individuals entering the field of software development. These roles provide aspiring developers with hands-on experience, mentorship, and an opportunity to contribute to real projects while building a foundation for their career growth.",
        image: "https://picsum.photos/301/400",
        dateCreated: '03/14/2022',
        clout: 3,
        upVote: 5,
        downVote: 2
      },
      {
        id: 4,
        forumId: 2,
        userId: 4,
        title: 'Taylor Swift New BF?',
        body: "In an unexpected turn of events, the American Superstar, Taylor Swift, has been spotted cozying up with a mystery artist, sparking rumors of a budding romance. Fans are eagerly awaiting official confirmation and speculating about this potential power couple's impact on both the music and Hollywood scenes.",
        image: "https://images.saatchiart.com/saatchi/2039119/art/9754975/8818047-JEDUMUTR-7.jpg",
        dateCreated: '07/11/2022',
        clout: -4,
        upVote: 0,
        downVote: 4
      },
      {
        id: 5,
        forumId: 1,
        userId: 1,
        title: 'Big O Notation',
        body: "Big O Notation, a key concept in computer science, provides a standardized way to express the efficiency of algorithms by characterizing their time or space complexity in relation to input size. It simplifies the comparison and analysis of algorithmic performance, aiding developers in making informed choices for designing scalable and efficient solutions.",
        image: "https://www.doabledanny.com/static/2637207240bc4e7dcc8bca66c62c0560/2a43b/feature.jpg",
        dateCreated: '02/14/2022',
        clout: 200,
        upVote:200,
        downVote:0
      },
      {
        id: 6,
        forumId: 7,
        userId: 5,
        title: 'Ryan Days Time Up?',
        body: "As the sporting landscape evolves, teams often find themselves at a crossroads, contemplating the prospect of a coaching change. Join the conversation as we discuss the factors that contribute to the decision of ushering in a new era with a fresh coaching perspective. From team performance and strategic vision to the dynamics of leadership, let's explore the signs that might indicate it's time for a change on the sidelines. Share your thoughts, insights, and opinions on what makes the perfect timing for a team to bring in a new coach and the potential impacts on the future of the game. ",
        image: "https://images.sidearmdev.com/crop?url=https%3A%2F%2Fdxbhsrqyrr690.cloudfront.net%2Fsidearm.nextgen.sites%2Fohiostatebuckeyes.com%2Fimages%2F2023%2F11%2F18%2F111823_FB_v_Minnesota_82.JPG&width=540&height=540",
        dateCreated: '08/14/2022',
        clout: 12,
        upVote: 23,
        downVote: 11
      },
      {
        id: 7,
        forumId: 6,
        userId: 2,
        title: 'Tensions Rising in Palestine',
        body: "In a world marked by geopolitical complexities, it's essential to delve into the ongoing tensions in Palestine with a nuanced perspective. Join us in a thoughtful and respectful discussion as we explore the historical context, current events, and the multifaceted aspects contributing to the tensions in the region. Share your insights, engage in conversations about potential resolutions, and stay informed about the impact of these tensions on the lives of people in the area. Our aim is to foster understanding, empathy, and awareness as we navigate through the complexities of this pressing issue. Let's engage in dialogue that encourages peaceful solutions and a path towards stability.",
        image: "https://media.npr.org/assets/img/2023/10/26/gettyimages-1238754440-71b4adae9b304a022fb2f3c82ef9207d66f5cf96-s1100-c50.jpg",
        dateCreated: '07/10/2022',
        clout: -47,
        upVote: 3,
        downVote: 50
      },
      {
        id: 8,
        forumId: 3,
        userId: 5,
        title: 'Van Gogh Inspiration',
        body: "Vincent van Gogh, the legendary Dutch artist, continues to captivate hearts with his timeless masterpieces. Join us as we embark on a journey into the vibrant and emotionally charged world of Van Gogh's art. From his iconic sunflowers to the swirling starry night sky, let's delve into the profound inspiration behind his work.",
        image: "https://i.pinimg.com/originals/35/94/d1/3594d121c1c289e72ea4e7fe52bf9a08.gif",
        dateCreated: '12/09/2023',
        clout: -1,
        upVote: 2,
        downVote: 3
      },
      {
        id: 9,
        forumId: 3,
        userId: 5,
        title: 'Art + Coding',
        body: "Step into the mesmerizing realm where art and coding collide! Join us on a journey to explore the innovative and visually stunning projects that arise from the synergy between artistic expression and programming expertise. From generative art and interactive installations to animations powered by algorithms, discover how creatives are pushing the boundaries of traditional art using the language of code. Engage in conversations about the latest tools, techniques, and the limitless possibilities that arise when art meets technology. Whether you're an artist looking to integrate code or a coder seeking to unleash your creative side, this is the space where inspiration knows no bounds!",
        image: "https://camo.githubusercontent.com/61491d59e71fec5c794945fed916a4a682b6c0404fc31f30b08a0d919c558404/68747470733a2f2f696d616765732e73717561726573706163652d63646e2e636f6d2f636f6e74656e742f76312f3537363966633430316236333162616231616464623261622f313534313538303631313632342d5445363451474b524a4738535741495553374e532f6b6531375a77644742546f6464493870446d34386b506f73776c7a6a53564d4d2d53784f703743563539425a772d7a505067646e346a557756634a45315a7657515578776b6d794578676c4e714770304976544a5a616d574c49327a76595748384b332d735f3479737a63703272795449304871544f6161556f68724938504936465879386339505774426c7141566c555335697a7064634958445a71445976707252715a32395077306f2f636f64696e672d667265616b2e676966",
        dateCreated: '04/14/2022',
        clout: 5,
        upVote: 5,
        downVote:0
      },
      {
        id: 10,
        forumId: 1,
        userId: 3,
        title: 'Top 10 Side Projects',
        body: "Looking to supercharge your coding prowess? Dive into a world of innovation and skill-building with our curated list of the top 10 coding side projects. From creating your own mobile app to building a personalized website or diving into open-source contributions, these projects offer a perfect blend of challenge and creativity. Join the discussion, share your experiences, and discover how these side projects can not only enhance your coding skills but also make a meaningful impact on your portfolio. Let the coding adventures begin!",
        image: "https://yt3.googleusercontent.com/ytc/APkrFKYLNsV9KKOx14NlioRaICEknmhkO5UvNx5gKPAG=s900-c-k-c0x00ffffff-no-rj",
        dateCreated: '07/14/2022',
        clout: 3,
        upVote:3,
        downVote:0
      },
        {
          id: 11,
        forumId: 7,
        userId: 5,
        title: 'Deshaun Watson Mistake!',
        body: 'Deshaun Watson was a mistake because we took a cost controlled quarterback that we could have signed to a reasonable contract and built the team around and tossed him.  Deshaun came with too much baggage, cost too much and had not played in 2 years.  This is worse than Jimmy drafting JFF',
        image:'https://www.cleveland.com/resizer/d7KTtoo3GLYDfFI4I0LyqTnVu7A=/800x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/PSHW3MVM2NESBA6AUSE2ODE32A.jpg',
        dateCreated: '12/06/2023',
        clout: 15,
        upVote: 25,
        downVote: 10
        },
        {
          id: 12,
          forumId: 2,
          userId: 3,
          title: 'Kanyes New Album!',
          body: "Get ready for a sonic journey like no other as Kanye West, the maestro of reinvention, drops his highly anticipated new album. Join the conversation as fans and music enthusiasts dissect the tracks, decipher the lyrics, and discuss the overall vibe of this latest musical creation. From unexpected collaborations to groundbreaking production, let's explore the artistic evolution and cultural impact of Kanye's newest masterpiece. Share your favorite tracks, memorable moments, and theories about the deeper meanings embedded in the album. It's time to immerse ourselves in the world of Yeezy and embrace the next chapter of his musical legacy!",
          image: "https://preview.redd.it/cuylsl10lkk81.png?auto=webp&s=cfbb32a73ea242f1a70c92024e6ece89a04855d2",
          dateCreated: '09/04/2023',
          clout: 7,
          upVote:10,
          downVote:3
        },
        {
          id: 13,
          forumId: 2,
          userId: 4,
          title: 'Drakes Hidden Message?',
          body: "The rap icon and Toronto native, Drake, has set tongues wagging with a mysterious social media post that seems to hold a cryptic message about a potential baseball blockbuster trade. Fans and sports enthusiasts alike are speculating on the hidden meaning behind Drake's latest Instagram or Twitter post, with many trying to connect the dots between his lyrics, emojis, and possible hints about player transfers.",
          image: "https://www.si.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MjAyNzc2MDYzNDY4NjQzMzk2/drake-jersey.jpg",
          dateCreated: '12/10/2021',
          clout: 3,
          upVote:3,
          downVote:0
        },
        {
          id: 14,
          forumId: 4,
          userId: 1,
          title: 'Cardio And Wine?',
          body: "Ever wondered if you can enjoy a good workout while sipping on your favorite glass of wine? Join us as we delve into the emerging trend that combines fitness and the love of wine. From wine-fueled cardio classes to wellness events that celebrate both the joys of movement and the pleasures of a fine vintage, discover how enthusiasts are embracing this unique fusion. Let's uncork the possibilities, explore the balance between indulgence and exercise, and perhaps find a new way to raise our heart rates while toasting to a healthier lifestyle. Cheers to the unexpected synergy of cardio and wine!",
          image: "https://vinepair.com/wp-content/uploads/2016/01/wine-fitness-social.png",
          dateCreated: '12/9/2022',
          clout: 30,
          upVote:30,
          downVote:0
        },
        {
          id: 15,
          forumId: 4,
          userId: 2,
          title: 'Best Yoga Alternatives',
          body: "For those seeking a holistic approach to well-being beyond traditional yoga, join us on a journey to discover alternative practices that nurture mind, body, and spirit. From dynamic workouts that fuse strength and flexibility to mindful meditation practices that promote inner calm, explore a range of alternatives tailored to diverse preferences and fitness levels. Whether you're a seasoned yogi looking to mix things up or a newcomer curious about holistic wellness, let's explore the myriad paths to self-discovery and balance. Embrace the diversity of well-being practices that extend beyond the yoga mat!",
          image: "https://mir-s3-cdn-cf.behance.net/project_modules/hd/2f572281374889.5cfe294fd0d7b.gif",
          dateCreated: '02/14/2020',
          clout: 3,
          upVote:13,
          downVote:10
        },
        {
          id: 16,
          forumId: 5,
          userId: 2,
          title: 'Niagara Trip Itinerary',
          body: "Embark on a journey of natural wonder and adventure with our comprehensive guide to planning the ultimate Niagara trip! From the iconic falls to charming nearby attractions, we'll help you curate an itinerary that maximizes your experience. Discover the best viewpoints, explore hidden gems, and find the tastiest local treats as you prepare for an unforgettable escapade to one of the world's most awe-inspiring destinations. Let the planning begin, and get ready to immerse yourself in the breathtaking magic of Niagara Falls!",
          image: "https://images.squarespace-cdn.com/content/v1/5f879a57f3f38524be9cc6cb/1629811536339-M1UNK5S9DQ5V84ARM8R7/Niagara-at-Night.gif",
          dateCreated: '10/07/2023',
          clout: 3,
          upVote:3,
          downVote:0
        },
        {
          id: 17,
          forumId: 6,
          userId: 5,
          title: 'Gaza Death Toll Rising',
          body: "In this crucial conversation, we address the heartbreaking and concerning situation as the death toll rises in Gaza. Join us to discuss the human impact, the complexities of the conflict, and the pressing need for a peaceful resolution. Let's foster understanding, empathy, and awareness as we explore the latest developments, humanitarian efforts, and the international community's role in addressing this urgent crisis. Our thoughts are with those affected, and together, we strive to shine a light on the path toward peace and justice.",
          image: "https://media.cnn.com/api/v1/images/stellar/prod/231208101322-gaza-bombing-120823.jpg?c=16x9&q=h_833,w_1480,c_fill",
          dateCreated: '11/14/2021',
          clout: 3,
          upVote:3,
          downVote:0
        },
        {
          id: 18,
          forumId: 7,
          userId: 3,
          title: 'Columbus Crew Champions!',
          body: "Join us in jubilation as we salute the Columbus Crew, the undisputed champions! After an exhilarating season filled with grit, teamwork, and unforgettable moments, the Crew has emerged victorious. Share your elation, relive the standout plays, and discuss the key moments that led to this well-deserved triumph. It's a celebration of soccer prowess and the unyielding spirit that defines champions. Congratulations to the Columbus Crew forever etched in the annals of soccer glory!",
          image: "https://www.dispatch.com/gcdn/authoring/authoring-images/2023/12/03/NCOD/71792993007-crew-1202-fcc-ac-80.JPG?width=660&height=440&fit=crop&format=pjpg&auto=webp",
          dateCreated: '07/14/2022',
          clout: 3,
          upVote:3,
          downVote:0
        },
        {
          id: 19,
          forumId: 6,
          userId: 2,
          title: 'Historic Landmarks Destroyed',
          body: "In this solemn discussion, we delve into the pages of history to mourn the loss of once-iconic landmarks that have succumbed to the ravages of time, conflict, or natural disasters. Join us as we remember and honor these architectural marvels, exploring their significance and the cultural heritage they held. Let's engage in a thoughtful reflection on the fragility of our shared history and the importance of preservation for generations to come.",
          image: "https://picsum.photos/301/407",
          dateCreated: '09/14/2020',
          clout: 3,
          upVote:3,
          downVote:0
        },
        {
          id: 20,
          forumId: 5,
          userId: 1,
          title: 'Exotic Flight Destinations',
          body: "Unleash Your Wanderlust: Discover Exotic Flight Destinations! Ready to elevate your travel dreams? Explore the extraordinary with our guide to the most exotic flight destinations. From hidden gems nestled in tropical paradises to culturally rich cities off the beaten path, join us as we embark on a journey to uncover the worlds most enchanting and unforgettable places. Get ready to add a touch of exotic allure to your travel bucket list!",
          image: "https://picsum.photos/306/400",
          dateCreated: '07/04/2022',
          clout: 3,
          upVote:3,
          downVote:0
        },
        {
          id: 21,
          forumId: 4,
          userId: 4,
          title: 'Need Help Dieting?',
          body: "Embarking on a journey to better health through dieting? Whether you're aiming for weight loss, muscle gain, or simply adopting a healthier lifestyle, our community is here to offer support, tips, and personalized advice. Join us in the quest for a balanced and sustainable diet that aligns with your fitness goals because achieving your best self starts with nourishing your body right!",
          image: "https://www.heartfoundation.org.au/getmedia/70195972-0139-4ce8-a170-ffdf2aa24f60/200615-Healthy-Eating-Gif3.gif",
          dateCreated: '08/14/2022',
          clout: 7,
          upVote:13,
          downVote:6
        },],
        Reply: [
          {
            id: 1,
            userId: 1,
            postId: 21,
            body: 'Great Post Appreciate the content!',
            upVote: 1,
            downVote: 0,
            clout: 1,
            dateCreated: '12/11/2023',
          },
          {
            id: 2,
            userId: 2,
            postId: 15,
            body: 'Informative Post Appreciate the content!',
            upVote: 1,
            downVote: 0,
            clout: 1,
            dateCreated: '10/11/2023',
          },
          {
            id: 3,
            userId: 3,
            postId: 21,
            body: 'Post needs more context! Appreciate the content!',
            upVote: 1,
            downVote: 1,
            clout: 0,
            dateCreated: '1/11/2023',
          },
          {
            id: 4,
            userId: 4,
            postId: 6,
            body: 'Amazing Post Appreciate the content!',
            upVote: 10,
            downVote: 1,
            clout: 9,
            dateCreated: '2/11/2022',
          },
          {
            id: 5,
            userId: 5,
            postId: 11,
            body: 'Good Post Appreciate the content!',
            upVote: 1,
            downVote: 10,
            clout: -9,
            dateCreated: '12/11/2022',
          },
          {
            id: 6,
            userId: 1,
            postId: 12,
            body: 'Do you have any citations available? Appreciate the content!',
            upVote: 0,
            downVote: 0,
            clout: 0,
            dateCreated: '5/11/2023',
          },
        ],
      postedUsers: [{
        userId: 1,
        userName: 'Jenny'
      },
    {
      userId: 2,
      userName: 'John'
    },
    {
      userId: 3,
      userName: 'Omar'
    },
    {
      userId: 4,
      userName: 'Mac'
    },
    {
      userId: 5,
      userName: 'Wayne'
    }]
    },
    mutations: {
      SET_AUTH_TOKEN(state, token) {
        state.token = token;
        state.isAuthenticated = !!token;
        localStorage.setItem('token', token);
        axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
      },
      SET_USER(state, user) {
        state.user = user;
        localStorage.setItem('user', JSON.stringify(user));
      },
      LOGOUT(state) {
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        state.token = '';
        state.user = {};
        state.isAuthenticated = false;
        axios.defaults.headers.common = {};
      },
      UPVOTE_POST(state, postId) {
        const post = state.posts.find(p => p.id === postId);
        if (post) {
          post.upVote += 1;
          post.clout = post.upVote - post.downVote;
        }
      },
      DOWNVOTE_POST(state, postId) {
        const post = state.posts.find(p => p.id === postId);
        if (post) {
          post.downVote += 1;
          post.clout = post.upVote - post.downVote;
        }
      },
      
      // SET_FORUMS(state, forums){
      //     state.forums = forums;
      //   },
        
      },
    
    actions: {
      upVotePost({ commit }, postId) {
        commit('UPVOTE_POST', postId);
      },
      downVotePost({ commit }, postId) {
        commit('DOWNVOTE_POST', postId);
      },
      async login({ commit }, user) {
        try {
          const response = await AuthService.login(user);
          // Handle successful login (commit mutations, set state, etc.)
          commit('SET_AUTH_TOKEN', response.token);
          commit('SET_USER', response.user);
        } catch (error) {
          // Handle login failure
          throw new Error('Login failed');
        }
      },
    }
  });
  return store;
}
