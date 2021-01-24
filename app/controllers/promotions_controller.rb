class PromotionsController < ApplicationController
  before_action :find_promotion, only: %i[show edit update destroy]

  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.create(promotion_params)
    return redirect_to @promotion if @promotion.save

    render :new
  end

  def show
  end

  def edit
  end

  def update
    return redirect_to @promotion if @promotion.update(promotion_params)

    render :edit
  end

  def destroy
    return redirect_to promotions_path if @promotion.delete

    render :index
  end

  private

  def promotion_params
    params.require(:promotion).permit(:name, :description, :code, :discount_rate,
                                      :coupon_quantity, :expiration_date)
  end

  def find_promotion
    @promotion = Promotion.find(params[:id])
  end
end
