class ProductsController < ApplicationController
  before_action :set_product, except: %i[new create index]
  skip_before_action :authenticate_user, only: [:index, :show]

  def index
    @categories = Category.order(name: :asc).load_async
    @pagy, @products = pagy_countless(FindProducts.new.call(product_params_index).load_async, items: 12)
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(secure_params)

    if @product.save
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize! product
    if @product.update(secure_params)
      redirect_to products_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! product
    @product.destroy
    redirect_to products_path, notice: t('.destroyed'), status: :see_other
  end

  def edit
    authorize! product
  end

  private

  def product_params_index
    params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page, :favorites, :user_id)
  end

  def set_product
    @product ||= Product.find(params[:id])
  end

  def secure_params
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end
end
