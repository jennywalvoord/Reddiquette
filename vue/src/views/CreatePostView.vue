<template>
  <v-main class="bg-grey-lighten-3">
    <v-container class="bg-grey-lighten-3">
      <v-row>

        <v-col>
          <v-sheet min-height="70vh" rounded="lg">
            <div class="custom-padding">
              <v-content>
                <div class="pb-6">
                  <v-text class="text-h4">Create a Post</v-text>
                  <p class="font-weight-bold py-4">Choose a forum to post to:</p>
                  <v-select class="py-4" label="Choose a forum"
                    :items="['Forum1', 'Forum2', 'Forum3', 'Forum4', 'Forum5', 'Forum6']"></v-select>
                  <p class="font-weight-bold py-4">Add text and an image: </p>

                  <v-tabs v-model="tab" color="#FF4500" align-tabs="center">
                    <v-tab :value="1">Post</v-tab>
                    <v-tab :value="2">Image</v-tab>
                  </v-tabs>

                  <v-window v-model="tab">
                    <v-window-item v-for="n in 3" :key="n" :value="n">
                      <!-- Content for Tab 1: Post -->
                      <v-container fluid v-if="tab === 1">
                        <v-sheet class="mx-auto">
                          <v-form @submit.prevent="createPost">
                            <v-text-field v-model="title" label="Title" :rules="titleRules"></v-text-field>
                            <v-row>
                              <v-textarea v-model="text" label="Text (Optional)"></v-textarea>
                            </v-row>

                            <v-btn type="submit" block class="mt-2">Post</v-btn>
                          </v-form>
                          <div>
                            <!-- ... (other code remains unchanged) ... -->
                          </div>
                        </v-sheet>
                      </v-container>

                      <!-- Content for Tab 2: Image -->
                      <v-container fluid v-else-if="tab === 2">
                        <v-row>

                          <v-file-input label="File input" variant="filled" prepend-icon="mdi-camera"></v-file-input>

                        </v-row>
                      </v-container>


                    </v-window-item>
                  </v-window>
                </div>



              </v-content>
            </div>
          </v-sheet>
        </v-col>

        <v-col cols="2">
          <v-sheet rounded="lg">
            <v-list rounded="lg">
              <v-list-item v-for="n in 5" :key="n" link :title="`List Item ${n}`"></v-list-item>

              <v-divider class="my-2"></v-divider>

              <v-list-item color="grey-lighten-4" link title="Refresh"></v-list-item>
            </v-list>
          </v-sheet>
        </v-col>

      </v-row>
    </v-container>
  </v-main>
</template>

<script>
// import TiptapRichTextEditor from '../components/TiptapRichTextEditor.vue';
import postService from '../services/PostService';
// import CommentService from '../services/CommentService';

export default {
  // props: ['forums'],
  // components: { TiptapRichTextEditor },
  data() {
    const currentDate = new Date();
    return {
      post: {
        UserId: this.$store.state.user.UserId,
        PostTitle: '',
        PostContent: 'This is hard coded',
        UpVotes: 0,
        DownVotes: 0,
        DateCreated: currentDate.toISOString(),
        ForumID: ''

      },
      postingErrors: false,
      postingErrorMsg: 'There were problems creating this post.',
      
      // components: {
      //   TiptapRichTextEditor
      // },
      tab: 1, // Set the initial value to 1 for the "Post" tab
    };
  },
  methods:{
    async createPost() {
    try {
      const response = await postService.createPost(this.post);

      if (response.status >= 200 && response.status < 300) {
        this.$router.push({
          path: '/posts',
          query: { posted: 'success' },
        });
      } else {
        // Handle unexpected response status
        console.error('Unexpected response status:', response.status);
      }
    } catch (error) {
      this.postingErrors = true;
      const response = error.response;

      if (response && response.status === 400) {
        this.postingErrorMsg = 'Bad Request: Validation Errors';
      } else {
        // Handle other errors
        console.error('Error creating post:', error);
      }
    }
  }
  }
};
</script>

<style>
.custom-padding {
  padding: 80px 60px;
}
</style>