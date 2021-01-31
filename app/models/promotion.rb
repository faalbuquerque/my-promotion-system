class Promotion < ApplicationRecord
  validates :name, :code, presence: true, uniqueness: true
  validates :discount_rate, :coupon_quantity, :expiration_date, presence: true
end
