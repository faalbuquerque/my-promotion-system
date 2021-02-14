class Promotion < ApplicationRecord
  has_many :coupons, dependent: :destroy
  has_one :promotion_approval
  belongs_to :admin

  has_many :category_promotions
  has_many :categories, through: :category_promotions

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

  def approve!(approval_admin)
    PromotionApproval.create(promotion: self, admin: approval_admin)
  end

  def approved?
    promotion_approval
  end

  def approver
    promotion_approval.admin
  end
end
