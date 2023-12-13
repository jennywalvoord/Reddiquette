<template>
  <v-app class="grey lighten-4">
    <v-app-bar app class="px-3 elevation-4" color="grey-lighten-4" height="72">
      <v-app-bar-nav-icon>
        <router-link to="/">
          <v-avatar size="48">
            <v-img src="./src/assets/Logo_Orange.png" width="100" height="100" />
          </v-avatar>
        </router-link>
      </v-app-bar-nav-icon>
      <v-app-bar-title class="font-weight-bold" :style="{ color: '#ff4500' }">ReddiQuette</v-app-bar-title>
      
      <!-- Centered search bar -->
      <v-row align="center" class="mx-auto">
        <v-col cols="12">
          <v-text-field
            v-model="search"
            placeholder="Search ReddiQuette"
            append-icon="mdi-magnify"
            single-line
            hide-details
          ></v-text-field>
        </v-col>
      </v-row>
      
      <router-link v-bind:to="{ name: 'home' }">Home</router-link>
      
      <v-list-item prepend-avatar="https://randomuser.me/api/portraits/women/81.jpg">
        <v-list-item-content>
          <v-list-item-title>{{ displayedUsername }}</v-list-item-title>
          <v-list-item-subtitle>
            <router-link v-if="isLoggedIn" to="/logout" class="text-subtitle-2">Log out</router-link>
            <router-link v-else to="/login" class="text-subtitle-2">Log in</router-link>
          </v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
    </v-app-bar>

    <router-view />
  </v-app>
</template>

<script>
import ForumService from '../src/services/ForumService';
import PostService from '../src/services/PostService';
import CommentService from '../src/services/CommentService';
export default {
  created() {
    ForumService.getForums().then(response => {
    this.$store.commit("SET_FORUMS", response.data);
    }  
    );
    PostService.getPosts().then(response =>{
    this.$store.commit("SET_POSTS", response.data);
    }  
    );
    CommentService.getComments().then(response =>{
    this.$store.commit("SET_COMMENTS", response.data);
    }  
    );
  }, 
  name: 'App',
  components: {},
  data() {
    return {

    }
    
  },
  
  computed: {
    isLoggedIn() {
      return !!this.$store.state.token;
    },
    user() {
      return this.$store.state.user;
    },
    displayedUsername() {

      if (this.user && this.user.username) {
        return this.user.username;
      } else {
        return 'Anonymous';
      }
    }
  }
}


</script>

<style>


div.nav{
  flex-flow: row;
}

input{
  align-items: center;
}
/* .global-padding {
  padding: 80px;
} */
</style>

