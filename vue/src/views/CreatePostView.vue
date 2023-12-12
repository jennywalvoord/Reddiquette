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

                  <v-window>
                    <v-window-item v-for="n in 3" :key="n" :value="n">
                      <v-container fluid>
                        <v-sheet class="mx-auto">
                          <v-form @submit.prevent="createPost">
                                <v-text-field 
                                  v-model="post.PostTitle" 
                                  label="Title" required></v-text-field>
                            
                              <div>
                                <v-textarea v-model="post.PostContent"
                                  bg-color="grey-lighten-2"
                                  color="cyan"
                                  label="Label"
                                ></v-textarea>

                                <v-text-field 
                                  v-model="post.ImagePath" 
                                  label="Add image url" 
                                  variant="filled" 
                                  prepend-icon="mdi-camera"
                                  ></v-text-field>

                                <!-- <tiptap-rich-text-editor /> -->
                              </div>
                            
                            <v-row>
                            </v-row>
                            <v-btn type="submit" block class="mt-2">Post</v-btn>
                          </v-form>
                        </v-sheet>
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
        UserId: this.$store.state.user.id,
        PostTitle: '',
        PostContent: '',
        UpVotes: 0,
        DownVotes: 0,
        DateCreated: currentDate.toISOString(),
        ForumID: '',
        ImagePath: '',
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