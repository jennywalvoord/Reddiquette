import { createStore as _createStore } from 'vuex';
import axios from 'axios';

export function createStore(currentToken, currentUser) {
  let store = _createStore({
    state: {
      token: currentToken || '',
      user: currentUser || {},
      forums:[{
        id: 1,
        title: "Tech Elevator",
        description: "",
        image:'',
      },
      {
        id: 2,
        title: "Tech Elevator2",
        description: "",
        image:'',
      },
      ],
      posts: [{
        id: 1,
        forumId: 1,
        title: 'Lorem Ipsum',
        body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Adipiscing commodo elit at imperdiet dui accumsan sit. Ut sem nulla pharetra diam. Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis. Ipsum dolor sit amet consectetur adipiscing. Orci dapibus ultrices in iaculis nunc sed augue lacus. Sed ullamcorper morbi tincidunt ornare massa. Libero volutpat sed cras ornare arcu dui vivamus arcu felis. In fermentum et sollicitudin ac orci phasellus. Justo nec ultrices dui sapien eget mi proin sed libero. Amet porttitor eget dolor morbi non arcu risus quis. Egestas quis ipsum suspendisse ultrices gravida. Porttitor leo a diam sollicitudin tempor id eu nisl nunc. Sed pulvinar proin gravida hendrerit lectus. Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna neque. \r\n Ipsum dolor sit amet consectetur adipiscing elit. Mauris augue neque gravida in fermentum et sollicitudin. Vehicula ipsum a arcu cursus. Viverra mauris in aliquam sem fringilla. Nunc sed id semper risus in hendrerit gravida rutrum quisque. Egestas integer eget aliquet nibh praesent tristique magna. Eu ultrices vitae auctor eu augue ut lectus arcu. Malesuada nunc vel risus commodo viverra maecenas accumsan lacus. Pharetra massa massa ultricies mi quis hendrerit dolor. Ut enim blandit volutpat maecenas volutpat blandit aliquam etiam erat. Condimentum id venenatis a condimentum vitae sapien. Neque sodales ut etiam sit amet nisl. Diam volutpat commodo sed egestas egestas fringilla. Ornare arcu odio ut sem nulla pharetra. Porta lorem mollis aliquam ut porttitor. Eget duis at tellus at urna condimentum mattis pellentesque. Sodales ut etiam sit amet nisl purus in. Nunc congue nisi vitae suscipit. Nunc lobortis mattis aliquam faucibus purus in massa tempor nec. Amet cursus sit amet dictum sit amet justo donec.",
        image: "https://picsum.photos/300/400",
        dateCreated: '07/14/2023',
        clout: 0,
        upVote: 0,
        downVote: 0
      },
      {
        id: 2,
        forumId: 1,
        title: 'Title2',
        body: "Non quam lacus suspendisse faucibus. Eget magna fermentum iaculis eu. Orci ac auctor augue mauris augue neque gravida in fermentum. Id diam maecenas ultricies mi eget mauris. Mattis enim ut tellus elementum sagittis vitae et leo duis.",
        image: "https://picsum.photos/300/402",
        dateCreated: '02/14/2021',
        clout: 0,
        upVote: 0,
        downVote: 0
      },
      {
        id: 3,
        forumId:1,
        title: 'Title3',
        body: "Volutpat blandit aliquam etiam erat velit scelerisque in dictum non. Quam adipiscing vitae proin sagittis. Quis blandit turpis cursus in hac habitasse platea dictumst.",
        image: "https://picsum.photos/301/400",
        dateCreated: '03/14/2022',
        clout: 0,
        upVote: 0,
        downVote: 0
      },
      {
        id: 4,
        forumId: 2,
        title: 'Title4',
        body: "At augue eget arcu dictum. Erat nam at lectus urna duis convallis. Massa placerat duis ultricies lacus sed turpis tincidunt id. Facilisis leo vel fringilla est.",
        image: "https://picsum.photos/300/401",
        dateCreated: '07/11/2022',
        clout: 0,
        upVote: 0,
        downVote: 0
      },
      {
        id: 5,
        forumId: 1,
        title: 'Title5',
        body: "alegfjobabgilbeakjgvbkjeaf Urna porttitor rhoncus dolor purus non enim praesent elementum. Aliquam ultrices sagittis orci a scelerisque purus semper eget.;gb kbbfuoigberuoigbouegoubeog",
        image: "https://picsum.photos/302/400",
        dateCreated: '02/14/2022',
        clout: 0,
        upVote:0,
        downVote:0
      },
      {
        id: 6,
        forumId: 2,
        title: 'Title6',
        body: "Netus et malesuada fames ac turpis egestas integer. Volutpat lacus laoreet non curabitur gravida arcu ac. ",
        image: "https://picsum.photos/303/400",
        dateCreated: '08/14/2022',
        clout: 0,
        upVote:0,
        downVote:0
      },
      {
        id: 7,
        forumId: 1,
        title: 'Title7',
        body: "algnoudfvobaobobafogubolbgouea;bgobeo;gboebgouberigblebguodfog",
        image: "https://picsum.photos/300/403",
        dateCreated: '07/10/2022'
      },
      {
        id: 8,
        forumId: 1,
        title: 'Title8',
        body: "Mauris vitae ultricies leo integer malesuada nunc vel risus commodo. Egestas sed tempus urna et pharetra. Nec feugiat in fermentum posuere. ;kdfjbj",
        image: "https://picsum.photos/304/400",
        dateCreated: '06/14/2022',
        clout: 0,
        upVote:0,
        downVote:0
      },
      {
        id: 9,
        forumId: 2,
        title: 'Title9',
        body: "Massa sed elementum tempus egestas sed. Vitae et leo duis ut diam quam nulla. Sem et tortor consequat id.;bnaeklugbuileguiuoibguofbguibf",
        image: "https://picsum.photos/300/404",
        dateCreated: '04/14/2022',
        clout: 0,
        upVote:0,
        downVote:0
      },
      {
        id: 10,
        forumId: 2,
        title: 'Title10',
        body: "Quam elementum pulvinar etiam non quam. Fames ac turpis egestas maecenas pharetra. Posuere morbi leo urna molestie at.",
        image: "https://picsum.photos/309/400",
        dateCreated: '07/14/2022',
        clout: 0,
        upVote:0,
        downVote:0
      }

      ]
    },
    mutations: {
      SET_AUTH_TOKEN(state, token) {
        state.token = token;
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
      }
    },
    actions: {
      upVotePost({ commit }, postId) {
        commit('UPVOTE_POST', postId);
      },
      downVotePost({ commit }, postId) {
        commit('DOWNVOTE_POST', postId);
      }
    }
  });
  return store;
}
