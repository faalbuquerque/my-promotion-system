class CouponsController < ApplicationController
  before_action :authenticate_admin!

  def inactivate
    @coupon = Coupon.find(params[:id])
    @coupon.inactive!

    redirect_to @coupon.promotion
  end
end
