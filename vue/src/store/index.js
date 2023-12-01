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
      }]
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
      }
    },
  });
  return store;
}
