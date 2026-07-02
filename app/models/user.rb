class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  FULL_WIDTH_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  KATAKANA_REGEX = /\A[ァ-ヶー]+\z/

  validates :nickname, :birth_date,
            :first_name, :last_name,
            :first_name_kana, :last_name_kana,
            presence: true

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /.+@.+/ }

  validates :password,
            presence: true,
            format: {
              with: PASSWORD_REGEX,
              message: "は半角英数字混合で入力してください"
            },
            length: {
              minimum: 6,
              message: "は6文字以上で入力してください"
            },
            confirmation: true

  validates :first_name, :last_name,
            format: { with: FULL_WIDTH_REGEX },
            allow_blank: true

  validates :first_name_kana, :last_name_kana,
            format: { with: KATAKANA_REGEX },
            allow_blank: true
end