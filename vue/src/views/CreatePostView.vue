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
                    <v-window>
                    <v-window-item v-for="n in 3" :key="n" :value="n">
                      <v-container fluid>
                        <v-sheet class="mx-auto">

                          
                          <v-form @submit.prevent="createPost">
                            <v-select 
                              class="py-4" 
                              label="Choose a forum"
                              :items="forumDropdown"
                              :item-value="id"
                              :item-title="title"
                              v-model="selectedForum"
                              return-object
                              ></v-select>
                            <p class="font-weight-bold py-4">Add text and an image: </p>

                                <v-text-field 
                                  v-model="post.PostTitle" 
                                  label="Title" required></v-text-field>
                            
                              <div>
                                <div class="content">
                                    <p>Enter your post content</p>
                                    <tiptap :modelValue="post.PostContent" @update:modelValue="updatePostContent" :enableEditing="true" />
                                  </div>
                                <!-- <v-textarea v-model="post.PostContent"
                                  bg-color="grey-lighten-2"
                                  color="cyan"
                                  label="Label"
                                ></v-textarea> -->

                                <v-text-field 
                                  v-model="post.ImagePath" 
                                  label="Add image url" 
                                  variant="filled" 
                                  prepend-icon="mdi-camera"
                                  ></v-text-field>
                              </div>
                              
                            <v-row>
                            </v-row>
                            <v-btn type="submit" block class="mt-10">Post</v-btn>
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
              <v-list-item color="grey-lighten-4" link title="Reddiquette Rules"></v-list-item>
              <v-divider class="my-2"></v-divider>
              <v-list-item class="text-caption" v-for="(rule, index) in rules" :key="index">
              {{ rule }}
              </v-list-item>
            </v-list>
          </v-sheet>
        </v-col>

      </v-row>
    </v-container>
  </v-main>
</template>

<script>
import Tiptap from '../components/Tiptap.vue';
import postService from '../services/PostService';
// import forumService from '../services/ForumService';
// import CommentService from '../services/CommentService';
export default {
 
  components: { Tiptap },
  data() {
    
    
    const currentDate = new Date();
    return {
     
      rules: ["No Trolls Allowed: Trolls live under bridges, not in our threads. Keep it friendly or face banishment to the land of Internet Outcasts.",
        "Meme Responsibly: Memes are great, but not when overused. One meme per post, please. We're allergic to meme overload.",
        "Grammar Police On Duty: We've hired the Grammar Police. Spelling errors and grammatical atrocities will be swiftly apprehended.",
        // Add other rules here
      ],
      forums : this.$store.state.forums,
      selectedForum: '',
      post: {
        UserId: this.$store.state.user.id,
        PostTitle: '',
        PostContent: '',
        DateCreated: currentDate.toISOString(),
        ForumID: '',
        ImagePath: '',
      },
      postingErrors: false,
      postingErrorMsg: 'There were problems creating this post.',
      
    };
  },
  methods:{
    async createPost() {
    try {
      this.post.ForumID = this.selectedForum.id;
      this.post.UserId = this.$store.state.user.userId;
      
      const response = await postService.createPost(this.post);
      if (response.status >= 200 && response.status < 300) {
        this.$router.push({
          path: `/forum/ ${this.post.ForumID}`,
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
  },
  updatePostContent(content) {
    this.post.PostContent = content;
  },
  },
  computed: {
    forumDropdown(){
      return this.$store.state.forums.map(f => {return {title: f.forumTitle, id: f.forumId}})
      }
  },
};
</script>

<style>
.tiptap {
  height: 140px;
  border: solid 0.5px lightslategray;
  border-radius: 8px;
  padding: 8px 16px;
}
.tiptap p {
  margin: 1em 0;
}

img {
    max-width: 100%;
    height: auto;
  }

  blockquote {
    padding-left: 1rem;
    border-left: 2px solid rgba(#0D0D0D, 0.1);
  }

  hr {
    border: none;
    border-top: 2px solid rgba(#0D0D0D, 0.1);
    margin: 2rem 0;
  }
code {
    background-color: rgba(#616161, 0.1);
    color: #616161;
  }
.custom-padding {
  padding: 80px 60px;
}

.content {
  margin-top: 20px;  /* Adjust the top margin as needed */
  border: 1px solid #ccc;  /* Add a border for visual separation */
  padding: 10px;
  margin-bottom: 20px;
  overflow-y: auto;  /* Enable vertical scroll if content overflows */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);  /* Add a subtle shadow */
}

/* Additional styles specific to tiptap content */
.content p {
  margin-bottom: 10px;
}

/* You may need to target specific tiptap elements based on its structure */
.content h1, .content h2, .content h3 {
  color: #333;
  font-weight: bold;
}
</style>