require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe 'userモデルの検証' do
    it 'userデータの作成' do
      expect(user).to be_valid
    end
  end

  describe 'バリデーション' do
    before { create(:user) }

    it '名前の必須' do
      user = User.new
      expect(user.valid?).to be false
      expect(user.errors[:name]).to include('を入力してください')
    end

    it '重複するメールアドレスの禁止' do
      duplicated_email = User.new(email: user.email)
      expect(duplicated_email.valid?).to be false
      expect(duplicated_email.errors[:email]).to include('はすでに存在します')
    end
  end
end
