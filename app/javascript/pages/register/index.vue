<template>
<section class="section is-medium is-relative is-clipped">
  <div class="is-hidden-touch has-background-danger" style="position: absolute; top: 0; left: 0; width: 70%; height: 100%"></div>
  <div class="is-hidden-desktop has-background-danger is-fullwidth" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%"></div>
  <div class="container mx-auto is-relative">
    <div class="is-vcentered columns is-multiline">
      <div class="column is-6 is-5-desktop mb-5 mt-10">
        <div>
          <h2 class="has-text-white mb-4 is-size-1 is-size-3-mobile has-text-weight-bold">SHERE TECH TUBE!!</h2>
          <p class="has-text-white mb-0 is-size-5">動画で勉強したこと、共有しませんか？</p>
        </div>
      </div>
      <div class="column is-6 is-4-desktop mx-auto">
        <div class="box has-background-light has-text-centered">
          <form action="#">
            <span class="has-text-grey-dark">Sign Up</span>
            <h3 class="mb-5 is-size-4 has-text-weight-bold">Create new account</h3>
            <div class="field">
              <div class="control">
                <input class="input" type="email" placeholder="E-mail address">
              </div>
            </div>
            <div class="field">
              <div class="control">
                <input class="input" type="text" placeholder="name">
              </div>
            </div>
            <div class="field">
              <div class="control">
                <input class="input" type="text" placeholder="ChannelId">
              </div>
            </div>
            <div class="field">
              <div class="control">
                <input class="input" type="password" placeholder="Password">
              </div>
            </div>
            <div class="field">
              <div class="control">
                <input class="input" type="password" placeholder="Repeat password">
              </div>
            </div>
            <div class="field">
              <label class="checkbox mb-4">
                <input class="checkbox mr-2" type="checkbox" name="terms" value="1">
                <small class="has-text-grey-dark"><a href="#">利用規約</a>、<a href="#">プライバシーポリシー</a>に同意する</small>
              </label>
            </div>
            <button class="button is-primary py-2 is-fullwidth"  @click="searchUser">Get Started</button>
          </form>
        </div>
      </div>
    </div>
  </div>
</section>
</template>

<script>
import axios from 'axios'
import $axios from '../../plugins/axios'

export default {
  name: "RegisterIndex",
  data() {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
      }
    }
  },
  methods: {
    register() {
      this.$axios.post('users', { user: this.user })
        .then(res => {
          this.$router.push({ name: 'TopIndex' })
        })
        .catch(err => {
          console.log(err)
        })
    },
    searchUser: function() {
      $axios
        .get("http://localhost:3000/api/users", {
        })
        .then(function(res) {
          console.log(res)
        })
        .catch(err => {
          console.log(err)
        })
    }
  }
}
</script>

<style scoped>
</style>
