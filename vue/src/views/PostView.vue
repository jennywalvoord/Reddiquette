<template>
    
    <v-sheet class="d-flex flex-wrap bg-surface-variant">
        <v-sheet class="flex-1-0 ma-24 pa-24">
            <post-section :post="findPost" />
        </v-sheet>
        <v-sheet class="ma-2 pa-2">
            <side-bar v-bind:forums="forums" />
        </v-sheet>
        <v-sheet class="flex-1-1-100 ma-2 pa-2">
        </v-sheet>
    </v-sheet>
</template>

<script>

import SideBar from '../components/SideBar.vue';
import PostSection from '../components/PostSection.vue';

export default {
    components: {
        SideBar,
        PostSection,
    },
    computed: {
        findPost() {
            let postId = this.$route.params.id;  
            let post = this.$store.state.posts.find((p) => p.id == postId);
            return post;
        }
    },
}
</script>