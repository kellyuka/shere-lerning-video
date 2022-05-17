module ApplicationHelper
  def default_meta_tags
    {
      title: 'ShareTechTube',
      description: 'ShareTechTubeはプログラミングに特化したyoutube共有プラットフォームです',
      keywords: 'youtube,プログラミング',
      noindex: !Rails.env.production?,
      canonical: request.original_url,
      charset: 'UTF-8',
      og: {
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        site_name: 'ShareTechTube',
        locale: 'ja_JP'
      },
      twitter: {
        creator: '@',
        card: 'summary_large_image'
      }
    }
  end
end
