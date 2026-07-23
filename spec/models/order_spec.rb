require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  context '内容に問題ない場合' do
    it 'userとitemがあれば保存できること' do
      expect(@order).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'userがないと保存できないこと' do
      @order.user = nil
      expect(@order).to be_invalid

      expect(@order.errors.full_messages).to include('Userを入力してください')
    end

    it 'itemがないと保存できないこと' do
      @order.item = nil
      expect(@order).to be_invalid

      expect(@order.errors.full_messages).to include('Itemを入力してください')
    end
  end
end
