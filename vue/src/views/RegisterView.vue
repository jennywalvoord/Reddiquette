<template>
<v-content>
    <v-container g-5>
      <v-card id="register" class="text-center ">
        <form id="register-form" v-on:submit.prevent="register">
          <v-card-title>Create Account</v-card-title>
          <div role="alert" v-if="registrationErrors">
            {{ registrationErrorMsg }}
          </div>
          <v-alert v-if="$route.query.registration" type="success">Thank you for registering, please sign in.</v-alert>
          <v-text-field v-model="user.username" label="Username" required autofocus></v-text-field>
          <v-text-field v-model="user.email" label="Email" type="email" required></v-text-field>
          
          <v-text-field v-model="user.password" label="Password" type="password" required></v-text-field>
          <v-text-field type="password" id="confirmPassword" v-model="user.confirmPassword" required></v-text-field>
          <v-btn type="submit" class="me-4 mb-4">Create Account</v-btn>
          <p>
            <router-link class="text-subtitle-2" v-bind:to="{ name: 'login' }">Already have an account? Log in.</router-link>
          </p>
        </form>
      </v-card>
    </v-container>
  </v-content>
  
  <!-- <v-content>
    <v-card>
      <v-card id="register" class="text-center bg-pink-lighten-5 text-black elevation-15">
        <form v-on:submit.prevent="register">
          <v-card-title>Create Account</v-card-title>
          <div role="alert" v-if="registrationErrors">
            {{ registrationErrorMsg }}
          </div>
          <div class="form-input-group">
            <label for="username">Username</label>
            <input type="text" id="username" v-model="user.username" required autofocus />
          </div>
          <div class="form-input-group">
            <label for="password">Password</label>
            <input type="password" id="password" v-model="user.password" required />
          </div>
          <div class="form-input-group">
            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword" v-model="user.confirmPassword" required />
          </div>
          <button type="submit">Create Account</button>
          <p><router-link class="text-subtitle-2" v-bind:to="{ name: 'login' }">Already have an account? Log in.</router-link></p>
        </form>
      </v-card>
    </v-card>
    
  </v-content> -->
  
</template>

<script>
import authService from '../services/AuthService';

export default {
  data() {
    return {
      user: {
        username: '',
        password: '',
        confirmPassword: '',
        role: 'user',
        email: ''
      },
      registrationErrors: false,
      registrationErrorMsg: 'There were problems registering this user.',
    };
  },
  methods: {
    register() {
      if (this.user.password != this.user.confirmPassword) {
        this.registrationErrors = true;
        this.registrationErrorMsg = 'Password & Confirm Password do not match.';
      } else {
        authService
          .register(this.user)
          .then((response) => {
            if (response.status == 201) {
              this.$router.push({
                path: '/login',
                query: { registration: 'success' },
              });
            }
          })
          .catch((error) => {
            const response = error.response;
            this.registrationErrors = true;
            if (response.status === 400) {
              this.registrationErrorMsg = 'Bad Request: Validation Errors';
            }
          });
      }
    },
    clearErrors() {
      this.registrationErrors = false;
      this.registrationErrorMsg = 'There were problems registering this user.';
    },
  },
};
</script>

<style scoped>
.form-input-group {
  margin-bottom: 1rem;
}
label {
  margin-right: 0.5rem;
}
#register {
 
  width: 400px;
  min-width: 300px;
  position: fixed;
  top: 100px; /* Adjust the distance from the top as needed */
  left: 50%; /* Center the card horizontally if needed */
  transform: translateX(-50%); /* Center the card horizontally */
}
#register-form {
  padding: 5%;
}
</style>
