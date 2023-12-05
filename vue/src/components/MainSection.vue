<template>
    <div>
        <v-container class="my-5">
        <v-layout row>
          <v-flex xs12 md6>
            <featured-post />
          </v-flex>
        </v-layout>
      </v-container>
      <v-container class="my-5">
        <v-layout row>
          <v-flex xs12 md>
            <small-post v-for="post in filteredPosts" v-bind:key="post.id" v-bind:post="post" />

          </v-flex>
        </v-layout>
      </v-container>
    </div>
</template>

<script>
import { storeKey } from 'vuex';
import FeaturedPost from '../components/FeaturedPost.vue'
import SmallPost from '../components/SmallPost.vue'

export default {
    components: {
        FeaturedPost,
        SmallPost,
    },
    computed: {
        filteredPosts() {
            const postFilter = this.$store.state.posts;
            return postFilter;
        }
    }
}

</script>

