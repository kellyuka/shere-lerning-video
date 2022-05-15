<template>
  <div class="modal is-active">
    <div
      class="modal-background"
      @click="Visiblemodal"
    />
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">
          Youtubeの再生リストとは
        </p>
        <button
          class="delete"
          aria-label="close"
          @click="Visiblemodal"
        />
      </header>
      <section class="modal-card-body">
        <div class="content">
          <p />
          <p>再生リストとは、動画を集めたものです。再生リストは誰でも作成して共有できます。</p>
          <h5>再生リストの作成</h5>
          <ol>
            <li>再生リストに追加する動画を探します。</li>
            <li>
              動画の下にある [<strong>保存</strong>]<img
                src="//lh3.googleusercontent.com/zcvhfCUM2oTZeKE8cwJB51QbNjXR2vBIYQO8uUM3VLT510_o7NtdGLZroVgfHHZtk88=w36"
                width="18"
                data-mime-type="image/png"
              > をクリックします。
            </li>
            <li>
              [後で見る] などの再生リスト、または自分が作成した再生リストを選択するか、[<strong>新しいプレイリストを作成</strong>] <img
                src="//storage.googleapis.com/support-kms-prod/DEE56D0771B1A634972568A5BC9C5F0708EE"
                width="18"
                data-mime-type="image/png"
              > をクリックします。
            </li>
            <li>ボックスを使用して再生リストの公開設定で、<strong>公開</strong>を選択します。公開にすることで、当サイトで選択可能になります。</li>
            <li>[<strong>作成</strong>] をクリックします。</li>
          </ol>
          <figure class="image is-16by9">
            <iframe 
              class="has-ratio" 
              src="https://www.youtube-nocookie.com/embed/xGfeZjF00N8?loop=1&playlist=xGfeZjF00N8" 
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; " 
              allowfullscreen
            />
          </figure>
        </div>
      </section>
      <footer class="modal-card-foot">
        <button
          class="button"
          @click="Visiblemodal"
        >
          閉じる
        </button>
      </footer>
    </div>
  </div>
</template>
<script>
export default {
  name: "Playlistmodal",
  methods: {
    Visiblemodal(){
      this.$emit('Visiblemodal')
    },
  },
}
</script>
