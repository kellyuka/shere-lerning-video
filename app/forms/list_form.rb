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
    super(attributes)
  end

  def save
    ActiveRecord::Base.transaction do
      tags = list_tags.map { |tag_name| Tag.where(name: tag_name).first_or_create }
      list.update!(user_id: user_id, title: title, recommend: recommend, playlistid: playlistid, tags: tags)
      videos.map { |video| Video.where(list_id: list, videoid: video).first_or_create }
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    list
  end

  private

  attr_reader :list
end
