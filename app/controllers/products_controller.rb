class ProductsController < ApplicationController
  before_action :set_product, except: %i[new create index]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(secure_params)

    if @product.save
      redirect_to products_path, notice: 'Product was created successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(secure_params)
      redirect_to products_path, notice: 'The product was updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: 'The product was deleted', status: :see_other
  end

  def edit; end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def secure_params
    params.require(:product).permit(:title, :description, :price)
  end
end
