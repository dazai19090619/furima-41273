class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :delivery_time

  with_options presence: true do
    validates :name
    validates :description
    validates :image
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :delivery_time_id
  end

  validates :price,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999
            }
end