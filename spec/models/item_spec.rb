require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
  @user = FactoryBot.create(:user)
  @item = FactoryBot.build(:item, user: @user)
end

  describe '商品出品' do
    context '出品できるとき' do
      it '全ての値が正しければ出品できる' do
        expect(@item).to be_valid
      end

      it '価格が300だと出品できる' do
        @item.price = 300
        expect(@item).to be_valid
      end

      it '価格が9,999,999だと出品できる' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it '画像がないと出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Imageを入力してください')
      end

      it '商品名がないと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Nameを入力してください')
      end

      it '説明がないと出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Descriptionを入力してください')
      end

      # ActiveHash のテスト（--- = id:1）
      it 'カテゴリーが---だと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Categoryを入力してください')
      end

      it 'カテゴリーが空だと出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Categoryを入力してください')
      end

      it 'カテゴリーがnilだと出品できない' do
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Categoryを入力してください')
      end

      it '商品の状態が---だと出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Statusを入力してください')
      end

      it '配送料の負担が---だと出品できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping feeを入力してください')
      end

      it '発送元の地域が---だと出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefectureを入力してください')
      end

      it '発送までの日数が---だと出品できない' do
        @item.delivery_time_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery timeを入力してください')
      end

      # price のテスト
      it '価格が空だと出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Priceを入力してください')
      end

      it '価格が300未満だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Priceは300以上9999999以下で入力してください')
      end

      it '価格が9999999を超えると出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Priceは300以上9999999以下で入力してください')
      end

      it '価格が半角数字以外だと出品できない（全角数字）' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Priceは半角数字で入力してください')
      end

      it '価格が数字以外だと出品できない（英字）' do
        @item.price = 'abc'
        @item.valid?
        expect(@item.errors.full_messages).to include('Priceは半角数字で入力してください')
      end

      it '価格が整数以外だと出品できない（小数）' do
        @item.price = 100.5
        @item.valid?
        expect(@item.errors.full_messages).to include('Priceは半角数字で入力してください')
      end

      # user のテスト
      it 'ユーザーが紐付いていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end

      it 'user_id が空文字だと出品できない' do
        @item.user_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
 describe '売却状態' do
  context '商品が購入された場合' do
    it 'orderが紐付いている' do
      item = FactoryBot.create(:item, user: @user)

      order = Order.new(
        user: @user,
        item: item
      )

      order.valid?

      puts order.errors.full_messages

      expect(order).to be_valid
    end
  end
end
end
