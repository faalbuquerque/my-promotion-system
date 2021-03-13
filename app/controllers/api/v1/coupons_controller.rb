class Api::V1::CouponsController < ApplicationController
  def show
    @coupon = Coupon.find_by(code: params[:id])

    return render status: 404, json: "{ message: 'Coupon not found' }" if @coupon.nil?

    render json: @coupon.as_json(only: [:code, :status],
                                 include: {
                                    promotion: { only: :discount_rate }
                                 }), status: 200
  end
end
