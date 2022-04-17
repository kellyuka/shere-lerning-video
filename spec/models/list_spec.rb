require 'rails_helper'

RSpec.describe List, type: :model do
  let(:list) { create(:list) }

  describe 'listモデルの検証' do
    it 'listデータの作成' do
      expect(list).to be_valid
    end
  end

end


