<template>
  <v-content>
    <v-container class="my-5">
      <v-layout row wrap>
        <v-flex xs12 md6 lg4 v-for="post in filteredPosts" :key="post.id">
          <small-post :post="post" />
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
import SmallPost from '../components/SmallPost.vue';

export default {
  props: ["forum","sortBy"],
  components: {
    SmallPost,
  },
  computed: {
    sortedPosts() {
      if (!this.forum || !this.forum.id) {
        return [];
      }

      let forumId = this.forum.id;
      let posts = this.$store.state.posts.filter((p) => p.forumId === forumId);

      if (this.sortBy === 'date') {
        posts.sort((a, b) => new Date(b.dateCreated) - new Date(a.dateCreated));
      } else if (this.sortBy === 'clout') {
        posts.sort((a, b) => b.clout - a.clout);
      } 
      return posts;
    },
  },
  
};
</script>