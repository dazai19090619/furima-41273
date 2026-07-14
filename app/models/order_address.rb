class OrderAddress
  include ActiveModel::Model

  attr_accessor :postal_code,
              :prefecture_id,
              :city,
              :address,
              :building,
              :phone_number,
              :user_id,
              :item_id,
              :token,
              :card_number,
              :card_exp_month,
              :card_exp_year,
              :card_cvc

  validates :postal_code, presence: true,
                          format: { with: /\A\d{3}-\d{4}\z/, message: 'は不正な値です' }

  validates :prefecture_id, numericality: { other_than: 1, message: 'を入力してください' }

  validates :city, presence: true
  validates :address, presence: true

  validates :phone_number, presence: true,
                           format: { with: /\A\d{10,11}\z/, message: 'は不正な値です' }

  # validates :token, presence: true

  def save
    order = Order.create!(
      user_id: user_id,
      item_id: item_id
    )

    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      address: address,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end