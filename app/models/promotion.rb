class Promotion < ApplicationRecord
  #belongs_to :admin
  has_many :coupons, dependent: :destroy

  validates :name, :code, presence: true, uniqueness: true
  validates :discount_rate, :coupon_quantity, :expiration_date, presence: true

  def create_coupons!
    Coupon.transaction do
      1.upto(coupon_quantity) do |num|
        #transformar num array de hashes e fazer um insert all
        coupons.create!(code: "#{ code }-#{ num.to_s.rjust(4, '0') }")
      end
    end
  end
end
