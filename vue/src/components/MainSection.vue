<template>
    <div>
        <featured-post />
        <small-post v-for="post in filteredPosts" v-bind:key="post.id" v-bind:post="post" />
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

