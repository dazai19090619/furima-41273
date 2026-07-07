class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_time

  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true

  validates :category_id, :status_id, :shipping_fee_id,
            :prefecture_id, :delivery_time_id,
            numericality: {
              other_than: 1,
              message: 'を入力してください'
            }

  validates :user_id, presence: true

  validates :price, presence: true

  validates :price,
            numericality: {
              only_integer: true,
              message: 'は半角数字で入力してください'
            }

  validates :price,
            numericality: {
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999,
              message: 'は300以上9999999以下で入力してください'
            }
end
