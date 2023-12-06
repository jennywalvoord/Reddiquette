<template>
    
    <v-sheet class="d-flex flex-wrap bg-surface-variant">
        <v-sheet class="flex-1-0 ma-24 pa-24">
            <forum-section v-bind:forum="findForum" />
        </v-sheet>
        <v-sheet class="ma-2 pa-2">
            <side-bar v-bind:forums="forums" />
        </v-sheet>
        <v-sheet class="flex-1-1-100 ma-2 pa-2">
        </v-sheet>
    </v-sheet>
</template>

<!-- <template>
<v-content >
    <div class="d-flex flex-wrap grey-lighten pa-24">
    <div class="flex-1-0 ma-24 pa-24">
      <forum-section />

</div>
    <v-navigation-drawer fixed permanent location="right">
      <div class="flex-1-0 ma-24 pa-24">
        <side-bar v-bind:forums="forums"/>
      </div>
    </v-navigation-drawer>
</div>

</v-content>

</template> -->

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