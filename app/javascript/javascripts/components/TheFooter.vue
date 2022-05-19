<template>
  <footer class="footer">
    <nav
      class="breadcrumb is-centered"
      aria-label="breadcrumbs"
    >
      <ul>
        <li>
          <a @click="VisiblePrivacy">プライバシーポリシー</a>
        </li>
        <li>
          <a @click="VisibleTearms">利用規約</a>
        </li>
      </ul>
      <p>Copyright &copy; 2022. ShareTechTube</p>
    </nav>
    <transition name="fade">
      <Teams
        v-if="Teamsmodal"
        @VisibleTearms="VisibleTearms"
      />
    </transition>
    <transition name="fade">
      <Privacy
        v-if="Privacymodal"
        @VisiblePrivacy="VisiblePrivacy"
      />
    </transition>
  </footer>
</template>

<script>
import Teams from '../../javascripts/components/teams.vue'
import Privacy from '../../javascripts/components/privacy_policy.vue'

export default {
  name: "Footer",
  components: {
    Teams,
    Privacy,
  },
  data() {
    return {
      Teamsmodal: false,
      Privacymodal: false,
    }
  },
  methods: {
    VisibleTearms(){
      if (this.Teamsmodal == false) {
        this.Teamsmodal = true
      } else {
        this.Teamsmodal = false
      }
    },
    VisiblePrivacy(){
      if (this.Privacymodal == false) {
        this.Privacymodal = true
      } else {
        this.Privacymodal = false
      }
    },
  }
}
</script>

<style scoped>
</style>
