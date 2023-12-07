<template>
    
    <v-sheet class="d-flex flex-wrap bg-surface-variant">
        <v-sheet class="flex-1-0 ma-24 pa-24">
            <main-section v-bind:forum="findPost" />
        </v-sheet>
        <v-sheet class="ma-2 pa-2">
            <side-bar v-bind:forums="forums" />
        </v-sheet>
        <v-sheet class="flex-1-1-100 ma-2 pa-2">
        </v-sheet>
    </v-sheet>
</template>

<script>

import MainSection from '../components/MainSection.vue';
import SideBar from '../components/SideBar.vue';
import SmallPost from '../components/SmallPost.vue'

export default {
    components: {
        SideBar,
        MainSection,
        SmallPost,
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