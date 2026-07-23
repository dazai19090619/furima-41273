class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :orders

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  FULL_WIDTH_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  KATAKANA_REGEX = /\A[ァ-ヶー]+\z/

  validates :nickname, presence: { message: 'を入力してください' }
  validates :birth_date, presence: { message: 'を入力してください' }

  validates :first_name, :last_name,
            presence: { message: 'を入力してください' },
            format: { with: FULL_WIDTH_REGEX, message: 'は不正な値です' }

  validates :first_name_kana, :last_name_kana,
            presence: { message: 'を入力してください' },
            format: { with: KATAKANA_REGEX, message: 'は不正な値です' }

  validates :email,
            presence: { message: 'を入力してください' },
            uniqueness: { message: 'はすでに存在します' },
            format: { with: /.+@.+/, message: 'は不正な値です' }

  validates :password,
            presence: { message: 'を入力してください' },
            format: {
              with: PASSWORD_REGEX,
              message: 'は半角英数字混合で入力してください'
            },
            length: {
              minimum: 6,
              message: 'は6文字以上で入力してください'
            },
            confirmation: { message: 'とPasswordの入力が一致しません' }
end
