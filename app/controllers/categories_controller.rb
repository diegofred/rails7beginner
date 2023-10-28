class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all.order(name: :asc)
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(secure_params)

    if @category.save
      redirect_to categories_url, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(secure_params)
      redirect_to categories_url, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy

    redirect_to categories_url, notice: t('.destroyed')
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def secure_params
    params.require(:category).permit(:name)
  end
end
