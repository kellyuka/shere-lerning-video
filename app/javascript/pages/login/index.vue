<template>
  <section class="hero is-danger is-medium">
    <div class="hero-body">
      <div class="container has-text-centered">
        <div class="column is-4 is-offset-4">
          <h3 class="title has-text-white">
            Let's Login
          </h3>
          <hr class="login-hr">
          <!-- form start -->
          <div class="box has-background-light has-text-centered">
            <span class="has-text-grey-dark">Sign In</span>
            <h3 class="mb-5 is-size-4 has-text-weight-bold">
              Join our community
            </h3>
            <div class="field">
              <div class="control">
                <input 
                  id="email"
                  v-model="user.email"
                  class="input" 
                  type="email" 
                  placeholder="メールアドレス"
                >
              </div>
            </div>
            <div class="field">
              <div class="control">
                <input 
                  id="password"
                  v-model="user.password"
                  class="input" 
                  type="password" 
                  placeholder="パスワード"
                >
              </div>
            </div>
            <button 
              class="button is-primary mb-4 is-fullwidth"
              @click="login"
            >
              Get Started
            </button>
            <a
              class="mb-4 is-inline-block"
              href="#"
            ><small>Forgot password?</small></a>
            <router-link
              :to="{ name: 'RegisterIndex' }"
              class="button is-white mb-2 is-flex is-justify-content-center is-align-items-center is-fullwidth"
            >
              <span class="has-text-grey-dark">create new account!</span>
            </router-link>
          </div>
          <!-- form end -->
        </div>
      </div>
    </div>
  </section>
</template>
<script>
import { mapActions } from "vuex"

export default {
  name: "LoginIndex",
  data() {
    return {
      user: {
        email: "",
        password: "",
      }
    }
  },
  
  methods: {
    ...mapActions("users", [
      "loginUser",
    ]),
    async login() {
      try {
        await this.loginUser(this.user);
        this.$router.push({ name: 'TopIndex' })
      } catch (error) {
        console.log(error);
      }
    }  
  }
}
</script>
