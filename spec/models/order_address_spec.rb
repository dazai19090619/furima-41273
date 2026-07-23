require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
  user = FactoryBot.create(:user)
  item = FactoryBot.create(:item)

  @order_address = FactoryBot.build(
    :order_address,
    user_id: user.id,
    item_id: item.id
  )
rescue ActiveRecord::RecordInvalid => e
  puts e.record.errors.full_messages
  raise
end

  describe '商品購入' do
    context '購入できる場合' do
      it '必要な情報が入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end
    end

    context '購入できない場合' do
      it 'postal_codeが空では購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal codeを入力してください')
      end

      it 'cityが空では購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Cityを入力してください')
      end

      it 'addressが空では購入できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Addressを入力してください')
      end

      it 'phone_numberが空では購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone numberを入力してください')
      end

      it 'tokenが空では購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Tokenを入力してください')
      end

      it '郵便番号がハイフンなしでは購入できない' do
        @order_address.postal_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal codeは不正な値です')
      end

      it '電話番号が10桁未満では購入できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone numberは不正な値です')
      end

      it 'prefecture_idが1では購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefectureを入力してください')
      end

      it '建物名が空でも購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end

      it '電話番号が12桁以上では購入できない' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
       expect(@order_address.errors.full_messages).to include('Phone numberは不正な値です')
      end

      it '電話番号に半角数字以外が含まれていると購入できない' do
       @order_address.phone_number = '090-1234-5678'
       @order_address.valid?
       expect(@order_address.errors.full_messages).to include('Phone numberは不正な値です')
      end

      it 'user_idが空では購入できない' do
       @order_address.user_id = nil
       @order_address.valid?
       expect(@order_address.errors.full_messages).to include('Userを入力してください')
      end

      it 'item_idが空では購入できない' do
       @order_address.item_id = nil
       @order_address.valid?
       expect(@order_address.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
