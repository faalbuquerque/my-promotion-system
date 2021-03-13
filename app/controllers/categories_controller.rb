class CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    return redirect_to @category if @category.save

    respond_to do |format|
      format.js { render partial: 'message' }
      format.html { render partial: 'result_message'}
    end
    #render :new
  end

  def show
  end

  def edit
  end

  def update
    return redirect_to @category if @category.update(category_params)

    respond_to do |format|
      format.js { render partial: 'message' }
      format.html { render partial: 'result_message'}
    end
    #render :edit
  end

  def destroy
    return redirect_to categories_path if @category.delete

    render :index
  end

  private

  def category_params
    params.require(:category).permit(:name, :code)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
