<template>
  <div class="home">
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

<style>
div.home {
  flex-flow: row;
}

</style>