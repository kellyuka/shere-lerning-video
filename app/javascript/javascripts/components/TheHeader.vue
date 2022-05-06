<template>
  <nav class="navbar">
    <div class="container">
      <div class="navbar-brand">
        <router-link
          :to="{ name: 'TopIndex' }"
          class="navbar-item has-text-danger"
        >
          <img
            class="image"
            src=""
            alt=""
            width="96px"
          >
          <strong>ShareTechTube</strong>
        </router-link>
        <a
          class="navbar-burger" 
          role="button" 
          aria-label="menu" 
          aria-expanded="false" 
          :class="{ 'is-active': burgerVisibillity }"
          @click="changeBurgerVisibillity"
        >
          <span aria-hidden="true" />
          <span aria-hidden="true" />
          <span aria-hidden="true" />
        </a>
      </div>
      <div
        class="navbar-menu"
        :class="{ 'is-active': burgerVisibillity }"
      >
        <div class="navbar-start">
          <a
            class="navbar-item"
            href="#"
          >About</a>
          <a
            class="navbar-item"
            href="#"
          >Category</a>
          <router-link
            :to="{ name: 'ListIndex' }"
            class="navbar-item"
          >
            ListIndex
          </router-link>
          <router-link
            :to="{ name: 'ListNew' }"
            class="navbar-item"
          >
            ListNew
          </router-link>
        </div>
        <div class="navbar-item">
          <div class="field has-addons">
            <div class="control">
              <input
                class="input"
                type="search"
                placeholder="Search"
                aria-label="Search"
              >
            </div>
            <div class="control">
              <button
                class="button"
                type="submit"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  style="width: 24px;height: 24px"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                  />
                </svg>
              </button>
            </div>
          </div>
        </div>
        <template v-if="!authUser">
          <div class="navbar-item">
            <router-link
              :to="{ name: 'LoginIndex' }"
              class="nav-link button is-danger"
            >
              ログイン
            </router-link>
          </div>
        </template>
        <template v-else>
          <div class="navbar-start">
            <div class="navbar-item">
              <router-link
                to="#"
                class="nav-link button is-danger"
                @click="handleLogout"
              >
                ログアウト
              </router-link>
            </div>
            <router-link
              :to="{ name: 'ProfileIndex' }"
              class="navbar"
            >
              <div class="navbar-item active avatar-image-wrapper ">
                <img
                  v-if="authUser.avatar_url"
                  :src="authUser.avatar_url"
                  alt="プロフィール画像"
                >
                <img
                  v-else
                  src="../../../assets/images/noimage.png"
                  alt="プロフィール画像"
                >
                <p>{{ authUser.name }}</p>
              </div>
            </router-link>
          </div>
        </template>
      </div>
    </div>
  </nav>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
export default {
  name: "Header",
  data() {
    return { burgerVisibillity: false };
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  methods: {
    changeBurgerVisibillity() {
      this.burgerVisibillity = !this.burgerVisibillity;
    },
    ...mapActions("users", ["logoutUser"]),
    async handleLogout() {
      try {
        await this.logoutUser()
        this.$router.push({name: 'TopIndex'})
        this.$notify({
          title: "ログアウトしました",
        });
      } catch (error) {
        console.log(error)
      }
    }
  }
}
</script>

<style scoped>
.navbar-menu a:hover{
  color:red
}
.avatar-image-wrapper {
  line-height: 40px;
}
.avatar-image {
  width: 20px;
}
</style>
