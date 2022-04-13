<template>
  <div
    id="login-form"
    class="container w-50 text-center"
  >
    <div class="h3 mb-3">
      ログイン
    </div>
    <div class="form-group text-left">
      <label for="email">メールアドレス</label>
      <input
        id="email"
        v-model="user.email"
        type="email"
        class="form-control"
        placeholder="test@example.com"
      >
    </div>
    <div class="form-group text-left">
      <label for="password">パスワード</label>
      <input
        id="password"
        v-model="user.password"
        type="password"
        class="form-control"
        placeholder="password"
      >
    </div>
    <button
      type="submit"
      class="btn btn-primary"
      @click="login"
    >
      ログイン
    </button>
  </div>
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
