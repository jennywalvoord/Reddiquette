<template>
  <div 
    style="
      display: flex;
      width: 40%;
      align-items: center;
      padding-top: 24px; /* Vertical alignment */
    "
  >
    <v-text-field 
      class="flex-1-0 ma-2 pa-2" 
      id="postInput" 
      v-model="inputValue" 
      @click="navigateToFormPage" 
      label="Create Post"
      prepend-inner-icon="mdi-plus"
      color="#ff4500"
    ></v-text-field>
  </div>
</template>

<script>
export default {
  methods: {
    navigateToFormPage() {
      this.$router.push({ name: 'create-post' });
    }
  },
}
</script>