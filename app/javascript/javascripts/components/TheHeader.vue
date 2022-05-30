<template>
  <nav class="navbar">
    <div class="container">
      <div class="navbar-brand">
        <router-link
          :to="{ name: 'AboutIndex' }"
          class="navbar-item has-text-danger"
          @click="changeBurgerVisibillity"
        >
          <img
            class="pr-4"
            src="../../../assets/images/desktop.png"
            alt="アイコン"
            height="20"
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
          <router-link
            :to="{ name: 'ListIndex' }"
            class="navbar-item"
            @click="changeBurgerVisibillity"
          >
            LISTS
          </router-link>
          <router-link
            v-if="authUser"
            :to="{ name: 'ListNew' }"
            class="navbar-item"
            @click="changeBurgerVisibillity"
          >
            NEW LIST
          </router-link>
        </div>
        <div class="navbar-end">
          <template v-if="authUser">
            <div class="navbar-item">
              <router-link
                :to="{ name: 'ProfileIndex' }"
                class="nav-link"
              >
                <div 
                  class="button is-rounded"
                  @click="changeBurgerVisibillity"
                >
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
            <div class="navbar-item">
              <div
                class="nav-link button is-danger"
                @click="handleLogout"
              >
                LOGOUT
              </div>
            </div>
          </template>
          <template v-else>
            <div class="navbar-item">
              <router-link
                :to="{ name: 'LoginIndex' }"
                class="nav-link button is-danger"
                @click="changeBurgerVisibillity"
              >
                LOGIN
              </router-link>
            </div>
          </template>
        </div>
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
        this.burgerVisibillity = !this.burgerVisibillity;
        this.$router.push({name: 'ListIndex'})
        this.$notify({
          title: "ログアウトしました",
        });
      } catch (error) {
        console.log(error)
      }
    },
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
