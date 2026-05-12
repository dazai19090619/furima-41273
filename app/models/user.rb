class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  FULL_WIDTH_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  KATAKANA_REGEX = /\A[ァ-ヶー]+\z/

  with_options presence: true do
    validates :nickname
    validates :birth_date
    validates :first_name, format: { with: FULL_WIDTH_REGEX }
    validates :last_name, format: { with: FULL_WIDTH_REGEX }
    validates :first_name_kana, format: { with: KATAKANA_REGEX }
    validates :last_name_kana, format: { with: KATAKANA_REGEX }
  end

  validates :password,
            format: { with: PASSWORD_REGEX, message: "は半角英数字混合で入力してください" }
end