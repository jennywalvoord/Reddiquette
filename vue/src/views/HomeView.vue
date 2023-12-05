<template>
  <div class="home">
    <v-app-bar :elevation="2">
      
      <v-app-bar-nav-icon><v-icon icon="$vuetify"></v-icon></v-app-bar-nav-icon>
      <v-app-bar-title>Rediquette</v-app-bar-title>
      <v-navigation drawer></v-navigation>
    </v-app-bar>
  <main-section />
  <side-bar v-bind:forums="forums"/>
  <!-- <forum v-for="forum in activeForums" v-bind:key="forum.id" /> -->
  </div>
</template>

<script>
import MainSection from '../components/MainSection.vue'
import SideBar from '../components/SideBar.vue';
// import Forum from '../components/Forum.vue';
export default {
  components: {
    MainSection,
    SideBar
    // Forum
  },
  // computed: {
  //       activeForums() {
  //           const forumsFilter = this.$store.state.forums;
  //           return forumsFilter;
  //       }
  //   }
};
</script>
