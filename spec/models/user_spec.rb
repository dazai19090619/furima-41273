require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'User新規登録' do
    context '新規登録できるとき' do
      it '全ての値が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nicknameを入力してください")
      end

      it 'emailが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Emailを入力してください")
      end

      it 'emailが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Emailはすでに存在します")
      end

      it 'emailに@を含まないと登録できない' do
        @user.email = 'testmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Emailは不正な値です")
      end

      it 'passwordが空だと登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Passwordを入力してください")
      end

      it 'passwordが6文字未満だと登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Passwordは6文字以上で入力してください")
      end

      it 'passwordが英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Passwordは半角英数字混合で入力してください')
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Passwordは半角英数字混合で入力してください')
      end

      it 'passwordに全角文字が含まれていると登録できない' do
        @user.password = 'あaaaa1'
        @user.password_confirmation = 'あaaaa1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Passwordは半角英数字混合で入力してください')
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password_confirmation = 'different'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmationとPasswordの入力が一致しません")
      end

      it 'first_nameが空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First nameを入力してください")
      end

      it 'last_nameが空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last nameを入力してください")
      end

      it 'first_name_kanaが空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanaを入力してください")
      end

      it 'last_name_kanaが空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanaを入力してください")
      end

      it 'first_nameが全角でないと登録できない' do
        @user.first_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("First nameは不正な値です")
      end

      it 'last_nameが全角でないと登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last nameは不正な値です")
      end

      it 'first_name_kanaがカタカナでないと登録できない' do
        @user.first_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanaは不正な値です")
      end

      it 'last_name_kanaがカタカナでないと登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanaは不正な値です")
      end

      it 'birth_dateが空だと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth dateを入力してください")
      end
    end
  end
end
