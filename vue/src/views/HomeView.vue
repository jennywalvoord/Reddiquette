<template>
  <div class="home">
<<<<<<< HEAD
    <main-section />
    <side-bar />
=======
  <main-section />
  <side-bar v-bind:forums="forums"/>
  <!-- <forum v-for="forum in activeForums" v-bind:key="forum.id" /> -->
>>>>>>> 81e5bdf55aa80bb56bd1f9d5366e1308e2c8e3fa
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