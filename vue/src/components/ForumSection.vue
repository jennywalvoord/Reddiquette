<template>
  
  <filter-bar />

  <v-main>
  <v-slide-group show-arrows>
    <v-slide-group-item
      v-for="post in filteredByDate"
      :key="post.id"
      >
        <small-post 
          :post="post" 
          class="ma-3"
          rounded
          width="250"/>
    </v-slide-group-item>
  </v-slide-group>
  
</v-main>

  
  <!-- <v-content>
    <v-container>
        <filter-bar />
        <v-row class="justify-center">
          <v-col cols="12" md="12">
            <v-row>
              <small-post class="ma-2" v-for="post in filteredByDate" :key="post.id" :post="post" />
           </v-row>
          </v-col>
        </v-row>
      </v-container>
  </v-content> -->
</template>

<script>

import { storeKey } from 'vuex';
import SmallPost from '../components/SmallPost.vue';
import FilterBar from './FilterBar.vue';

export default {
  props: ["forum"],
  components: {
    SmallPost,
    FilterBar,
  },
  computed: {
    filteredByDate() {
      let forumId = this.forum.id;
    let posts = this.$store.state.posts.filter((p) => p.forumId === forumId);
    posts.sort((a, b) => new Date(b.dateCreated) - new Date(a.dateCreated));
    return posts;
    },
    computed: {
        filteredPosts() {
            let thisForumId = this.forum.id;  
            let posts = this.$store.state.posts.filter((p) => { p.forumId === thisForumId});
            return posts;
        }
    }
  }
}
</script>

















