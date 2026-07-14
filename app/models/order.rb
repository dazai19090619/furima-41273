class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :address
endapp/models/address.rb