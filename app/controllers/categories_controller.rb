class CategoriesController < ApplicationController

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
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    return redirect_to @category if @category.update(category_params)

    render :edit
  end

  private

  def category_params
    params.require(:category).permit(:name, :code)
  end
end
