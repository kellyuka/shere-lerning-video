require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }

  describe 'commentモデルの検証' do
    it 'commentデータの作成' do
      expect(comment).to be_valid
    end
  end

  describe 'バリデーション' do
    it 'ユーザーの必須' do
      comment = Comment.new
      expect(comment.valid?).to be false
      expect(comment.errors[:user])
    end
    it 'リストの必須' do
      comment = Comment.new
      expect(comment.valid?).to be false
      expect(comment.errors[:list])
    end
  end
end
