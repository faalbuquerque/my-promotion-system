class PromotionsController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_promotion, except: %i[index new create search]

  def index
    @promotions = Promotion.all
  end

  def new
    @promotion = Promotion.new
    @categories = Category.all.order(name: :asc)
  end

  def create
    @promotion = Promotion.create(promotion_params)
    @promotion.admin = current_admin
    return redirect_to @promotion if @promotion.save

    @categories = Category.all.order(name: :asc)
    render :new
  end

  def show
  end

  def edit
    @categories = Category.all.order(name: :asc)
  end

  def update
    return redirect_to @promotion if @promotion.update(promotion_params)
    @categories = Category.all.order(name: :asc)

    render :edit
  end

  def destroy
    return redirect_to promotions_path if @promotion.destroy!

    render promotions_path
  end

  def creates_coupons
    return redirect_to @promotion, notice: t('.burned') if @promotion.coupons.any?
    @promotion.create_coupons!

    redirect_to @promotion, notice: t('.success')
  end

  def approve
    find_promotion.approve!(current_admin)
    redirect_to find_promotion
  end

  def search
    @result_set = Promotion.where('name like ? OR description like ?', 
                                  "%#{params[:q]}%",
                                  "%#{params[:q]}%")
    @result_set += (Coupon.where('code like ?', "%#{params[:q]}%"))
  end

  private

  def promotion_params
    params.require(:promotion).permit(:name, :description, :code, :discount_rate,
                                      :coupon_quantity, :expiration_date, category_ids: [] )
  end

  def find_promotion
    @promotion = Promotion.find(params[:id])
  end
end
