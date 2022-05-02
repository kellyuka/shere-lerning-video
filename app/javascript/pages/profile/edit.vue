<template>
  <div class="box">
    <div class="field">
      <label class="label">メールアドレス</label>
      <div class="control">
        <input
          id="email"
          v-model="user.email"
          class="input" 
          type="email" 
        >
      </div>
    </div>
    <div class="field">
      <label class="label">ユーザー名</label>
      <div class="control">
        <input 
          id="name"
          v-model="user.name"
          class="input"
          type="text" 
          placeholder="30字以内"
        >
      </div>
    </div>
    <div class="field">
      <label class="label">チャンネルID</label>
      <div class="control">
        <input 
          id="channelid"
          v-model="user.channelid"
          class="input"
          type="text"
        >
      </div>
    </div>
    <div class="field">
      <label class="label">プロフィール画像</label>
      <div class="tile">
        <div class="file is-boxed is-danger">
        <label class="file-label">
          <input
            class="file-input"
            type="file"
            name="resume"
            @change="handleChange"
          >
          <span class="file-cta">
            <ion-icon name="folder"></ion-icon>
            <span class="file-label">Choose a file…</span>
          </span>
          <span class="file-name">
            {{ filename }}
          </span>
        </label>
        </div>
        <div class="ml-4">
          <img
          :src="user.avatar_url"
          class="image is-128x128"
          >
        </div>
      </div>
    </div>
    <div class="field is-grouped">
      <div class="control">
        <button
          class="button is-danger"
          @click="updateuser"
        >
          更新
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: "ProfileEdit",
  data() {
    return {
      user: {
        name: "",
        email: '',
        channelid: '',
        password: '',
        password_confirmation: '',
        avatar_url: "",
        avatar: "",
      },
      uploadAvatar: "",
      filename: "No file uploaded",
      url: '',
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
  },
  created() {
    this.user = this.authUser
  },
  methods: {
    ...mapActions("users", ["updateUser"]),
    handleChange(event) {
      this.uploadAvatar = event.target.files[0]
      if (this.uploadAvatar.name.length > 0) {
        this.filename = this.uploadAvatar.name
        this.user.avatar_url = URL.createObjectURL(this.uploadAvatar)
      }
    },
    updateuser() {
      const formData = new FormData()
      formData.append("user[email]", this.user.email)
      formData.append("user[name]", this.user.name)
      formData.append("user[channelId]", this.user.channelid)
      if (this.uploadAvatar)
        formData.append("user[avatar]", this.uploadAvatar)
      this.user.avatar = this.uploadAvatar
      console.log(this.user)
      try {
        this.updateUser(formData)
        this.$router.push({ name: "ListIndex" })
      } catch (error) {
        console.log(error);
      }

    }
  }
}
</script>
<style scoped>
</style>
