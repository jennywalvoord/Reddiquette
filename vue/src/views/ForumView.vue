<template>
    <div>
        <forum-section v-bind:forum="findForum"/>
        <side-bar v-bind:forums="forums"/>
    </div>
</template>

<script>
import ForumSection from '../components/ForumSection.vue';
import SideBar from '../components/SideBar.vue';

export default {
    components: {
        SideBar,
        ForumSection,
    },
    computed: {
        findForum() {
            let forumId = this.$route.params.id;  
            let forum = this.$store.state.forums.find((p) => p.id == forumId);
            return forum;
        }
    },
}


</script>