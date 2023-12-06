<template>
<v-content>
  <div>
        <v-container class="my-5">
        <v-layout row>
          <v-flex xs12 md6 lg1>
            <small-post v-for="post in filteredPosts" v-bind:key="post.id" v-bind:post="post" />
          </v-flex>
        </v-layout>
      </v-container>
    </div>

</v-content>

    
</template>

<script>
import { storeKey } from 'vuex';
import SmallPost from './SmallPost.vue';

export default {
    props: ["forum"],
    components: {
        SmallPost,
    },
    computed: {
        filteredPosts() {
            let forumId = this.forum.id;  
            let posts = this.$store.state.forums.filter((p) => { p.id == forumId});
            return posts;
        }
    }
}

</script>