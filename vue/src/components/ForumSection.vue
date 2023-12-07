<template>
  <v-content>
    <div>
      <v-container class="my-5">
        <v-layout row>
          <v-flex xs12 md6 lg1>
            <small-post
              v-for="post in sortedPosts"
              :key="post.id"
              :post="post"
            />
          </v-flex>
        </v-layout>
      </v-container>
    </div>
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