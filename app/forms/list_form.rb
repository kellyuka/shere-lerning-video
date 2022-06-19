class ListForm
  include ActiveModel::Model
  attr_accessor :title, :recommend, :playlistid, :videos, :list_tags, :user_id

  with_options presence: true do
    validates :title, presence: true, length: { maximum: 100 }
    validates :recommend, presence: true, length: { maximum: 1000 }
    validates :playlistid, presence: true
    validates :user_id, presence: true
  end

  delegate :persisted?, to: :list

  def initialize(attributes = nil, list: List.new)
    @list = list
    attributes ||= default_attributes
    # ||= はassignment operatorであり、左側がnil, falseの場合、attributesにdefault_attributesが代入される
    super(attributes)
  end

  def save
    ActiveRecord::Base.transaction do
      tags = list_tags.map { |tag_name| Tag.find_or_create_by(name: tag_name) }
      @list.update!(user_id: user_id, title: title, recommend: recommend, playlistid: playlistid, tags: tags)
      @list.videos.destroy_all
      videos.map { |video| @list.videos.create(videoid: video) }
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    list
  end

  private

  def default_attributes
    {
      title: list.title,
      recommend: list.recommend,
      playlistid: list.playlistid,
      videos: list.videos,
      list_tags: list.list_tags,
      user_id: list.user_id
    }
  end

  attr_reader :list
end
