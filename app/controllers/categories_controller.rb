class CategoriesController < ApplicationController
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

    render :new
  end

  def show
  end

  def edit
  end

  def update
    return redirect_to @category if @category.update(category_params)

    render :edit
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
