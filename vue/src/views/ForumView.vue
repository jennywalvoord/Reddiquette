<template>
  <main class="d-flex flex-wrap grey-lighten pa-24">
    <div class="ma-24 pa-24">
      <v-container class="d-flex">
        <v-row>
          <v-col cols="12" md="12">
            <forum-section v-bind:forum="findForum" />
          </v-col>
        </v-row>
      </v-container>
    </div>

    <v-navigation-drawer fixed permanent location="right">
      <div class="ma-24 pa-24">
        <side-bar v-bind:forums="forums" />
      </div>
    </v-navigation-drawer>
  </main>
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

<style>
main {
  margin-top: 2.5%;
}
</style>