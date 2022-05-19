<template>
  <div>
    <Header />
    <notifications />
    <router-view />
    <Footer />
  </div>
</template>

<script>
import Header from './javascripts/components/TheHeader.vue'
import Footer from './javascripts/components/TheFooter.vue'

export default {
  components: {
    Header,
    Footer
  },
}
</script>
<style>
.fade-enter-active, .fade-leave-active {
  transition: opacity .1s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>
