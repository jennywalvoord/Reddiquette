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
      ],
      posts: [{
        userId: 1,
        id: 1,
        forumId: 1,
        
        title: 'Lorem Ipsum',
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing commodo elit at imperdiet dui accumsan sit. Ut sem nulla pharetra diam. Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Ipsum dolor sit amet consectetur adipiscing. Orci dapibus ultrices in iaculis nunc sed augue lacus. Sed ullamcorper morbi tincidunt ornare massa. Libero volutpat sed cras ornare arcu dui vivamus arcu felis. In fermentum et sollicitudin ac orci phasellus. Justo nec ultrices dui sapien eget mi proin sed libero. Amet porttitor eget dolor morbi non arcu risus quis. Egestas quis ipsum suspendisse ultrices gravida. Porttitor leo a diam sollicitudin tempor id eu nisl nunc. Sed pulvinar proin gravida hendrerit lectus. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna neque. \r\n Ipsum dolor sit amet consectetur adipiscing elit. Mauris augue neque gravida in fermentum et sollicitudin. Vehicula ipsum a arcu cursus. Viverra mauris in aliquam sem fringilla. Nunc sed id semper risus in hendrerit gravida rutrum quisque. Egestas integer eget aliquet nibh praesent tristique magna. Eu ultrices vitae auctor eu augue ut lectus arcu. Malesuada nunc vel risus commodo viverra maecenas accumsan lacus. Pharetra massa massa ultricies mi quis hendrerit dolor. Ut enim blandit volutpat maecenas volutpat blandit aliquam etiam erat. Condimentum id venenatis a condimentum vitae sapien. Neque sodales ut etiam sit amet nisl. Diam volutpat commodo sed egestas egestas fringilla. Ornare arcu odio ut sem nulla pharetra. Porta lorem mollis aliquam ut porttitor. Eget duis at tellus at urna condimentum mattis pellentesque. Sodales ut etiam sit amet nisl purus in. Nunc congue nisi vitae suscipit. Nunc lobortis mattis aliquam faucibus purus in massa tempor nec. Amet cursus sit amet dictum sit amet justo donec.",
        image: "https://picsum.photos/300/400",
        dateCreated: '07/14/2023',
        clout: 15,
        upVote: 7,
        downVote: 8,
    },
      
      {
        id: 2,
        forumId: 5,
        userId: 1,
        title: 'Title2',
        body: "Non quam lacus suspendisse faucibus. Eget magna fermentum iaculis eu. Orci ac auctor augue mauris augue neque gravida in fermentum. Id diam maecenas ultricies mi eget mauris. Mattis enim ut tellus elementum sagittis vitae et leo duis.",
        image: "https://picsum.photos/300/402",
        dateCreated: '02/14/2021',
        clout: 10,
        upVote: 23,
        downVote: 13
      },
      {
        id: 3,
        forumId:1,
        userId: 4,
        title: 'Title3',
        body: "Volutpat blandit aliquam etiam erat velit scelerisque in dictum non. Quam adipiscing vitae proin sagittis. Quis blandit turpis cursus in hac habitasse platea dictumst.",
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
        title: 'Title4',
        body: "At augue eget arcu dictum. Erat nam at lectus urna duis convallis. Massa placerat duis ultricies lacus sed turpis tincidunt id. Facilisis leo vel fringilla est.",
        image: "https://picsum.photos/300/401",
        dateCreated: '07/11/2022',
        clout: -4,
        upVote: 0,
        downVote: 4
      },
      {
        id: 5,
        forumId: 1,
        userId: 1,
        title: 'Title5',
        body: "alegfjobabgilbeakjgvbkjeaf Urna porttitor rhoncus dolor purus non enim praesent elementum. Aliquam ultrices sagittis orci a scelerisque purus semper eget.;gb kbbfuoigberuoigbouegoubeog",
        image: "https://picsum.photos/302/400",
        dateCreated: '02/14/2022',
        clout: 200,
        upVote:200,
        downVote:0
      },
      {
        id: 6,
        forumId: 7,
        userId: 5,
        title: 'Title6',
        body: "Netus et malesuada fames ac turpis egestas integer. Volutpat lacus laoreet non curabitur gravida arcu ac. ",
        image: "https://picsum.photos/303/400",
        dateCreated: '08/14/2022',
        clout: 12,
        upVote: 23,
        downVote: 11
      },
      {
        id: 7,
        forumId: 6,
        userId: 2,
        title: 'Title7',
        body: "algnoudfvobaobobafogubolbgouea;bgobeo;gboebgouberigblebguodfog",
        image: "https://picsum.photos/300/403",
        dateCreated: '07/10/2022',
        clout: -47,
        upVote: 3,
        downVote: 50
      },
      {
        id: 8,
        forumId: 3,
        userId: 5,
        title: 'Title8',
        body: "Mauris vitae ultricies leo integer malesuada nunc vel risus commodo. Egestas sed tempus urna et pharetra. Nec feugiat in fermentum posuere. ;kdfjbj",
        image: "https://picsum.photos/304/400",
        dateCreated: '06/14/2022',
        clout: -1,
        upVote: 2,
        downVote: 3
      },
      {
        id: 9,
        forumId: 3,
        userId: 5,
        title: 'Title9',
        body: "Massa sed elementum tempus egestas sed. Vitae et leo duis ut diam quam nulla. Sem et tortor consequat id.;bnaeklugbuileguiuoibguofbguibf",
        image: "https://picsum.photos/300/404",
        dateCreated: '04/14/2022',
        clout: 5,
        upVote: 5,
        downVote:0
      },
      {
        id: 10,
        forumId: 1,
        userId: 3,
        title: 'Title10',
        body: "Quam elementum pulvinar etiam non quam. Fames ac turpis egestas maecenas pharetra. Posuere morbi leo urna molestie at.",
        image: "https://picsum.photos/309/400",
        dateCreated: '07/14/2022',
        clout: 3,
        upVote:3,
        downVote:0
      },
        {
          id: 11,
        forumId: 7,
        userId: 5,
        title: 'Deshaun Watson mistake',
        body: 'Deshaun Watson was a mistake because we took a cost controlled quarterback that we could have signed to a reasonable contract and built the team around and tossed him.  Deshaun came with too much baggage, cost too much and had not played in 2 years.  This is worse than Jimmy drafting JFF',
        image:'https://www.cleveland.com/resizer/d7KTtoo3GLYDfFI4I0LyqTnVu7A=/800x0/smart/cloudfront-us-east-1.images.arcpublishing.com/advancelocal/PSHW3MVM2NESBA6AUSE2ODE32A.jpg',
        dateCreated: '12/7/2023',
        clout: 15,
        upVote: 25,
        downVote: 10
        }],
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
