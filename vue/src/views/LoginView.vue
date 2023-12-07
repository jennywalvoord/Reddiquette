<template>
  <v-content>
    <v-container>
      <v-card id="login" class="text-center ">
        <form id="login-form" @submit.prevent="login">
          <v-card-title>Please Sign In</v-card-title>
          <v-alert v-if="invalidCredentials" type="error">Invalid username and password!</v-alert>
          <v-alert v-if="$route.query.registration" type="success">Thank you for registering, please sign in.</v-alert>
          <v-text-field v-model="user.username" label="Username" required autofocus></v-text-field>
          <v-text-field v-model="user.password" label="Password" type="password" required></v-text-field>
          <v-btn type="submit" class="me-4 mb-4">Sign in</v-btn>
          <p>
            <router-link class="text-subtitle-2" :to="{ name: 'register' }">Need an account? Sign up.</router-link>
          </p>
        </form>
      </v-card>
    </v-container>
  </v-content>
</template>

<!-- <template>
<form @submit.prevent="submit">
    <v-text-field
      v-model="name.value.value"
      :counter="10"
      :error-messages="name.errorMessage.value"
      label="Name"
    ></v-text-field>

    <v-text-field
      v-model="email.value.value"
      :error-messages="email.errorMessage.value"
      label="E-mail"
    ></v-text-field>

    <v-select
      v-model="select.value.value"
      :items="items"
      :error-messages="select.errorMessage.value"
      label="Select"
    ></v-select>

    <v-checkbox
      v-model="checkbox.value.value"
      :error-messages="checkbox.errorMessage.value"
      value="1"
      label="Option"
      type="checkbox"
    ></v-checkbox>

    <v-btn
      class="me-4"
      type="submit"
    >
      submit
    </v-btn>

    <v-btn @click="handleReset">
      clear
    </v-btn>
  </form>


  <v-content>
    <v-card id="login" class="text-center bg-pink-lighten-5 text-black elevation-15">
      <form id="login-form" v-on:submit.prevent="login">
        <v-card-title>Please Sign In</v-card-title>
        <div role="alert" v-if="invalidCredentials">
          Invalid username and password!
        </div>
        <div role="alert" v-if="this.$route.query.registration">
          Thank you for registering, please sign in.
        </div>
        <div class="form-input-group">
          <label for="username">Username</label>
          <input type="text" id="username" v-model="user.username" required autofocus />
        </div>
        <div class="form-input-group">
          <label for="password">Password</label>
          <input type="password" id="password" v-model="user.password" required />
        </div>
        <button type="submit">Sign in</button>
        <p>
          <router-link class="text-subtitle-2" v-bind:to="{ name: 'register' }">Need an account? Sign up.</router-link>
        </p>
      </form>
    </v-card>
  </v-content>
</template> -->

<script>
import authService from "../services/AuthService";

export default {
  components: {},
  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      invalidCredentials: false
    };
  },
  methods: {
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            this.$router.push("/");
          }
        })
        .catch(error => {
          const response = error.response;

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    }
  }
};
</script>

<style scoped>
.form-input-group {
  margin-bottom: 1rem;
}
label {
  margin-right: 0.5rem;
}
#login {
  /* margin: 10% auto auto auto; */
  width: 400px;

  min-width: 300px;
  position: fixed;
  top: 100px; /* Adjust the distance from the top as needed */
  left: 50%; /* Center the card horizontally if needed */
  transform: translateX(-50%); /* Center the card horizontally */
}
#login-form {
  padding: 5%;
}
</style>