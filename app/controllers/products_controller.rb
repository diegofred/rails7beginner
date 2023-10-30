class ProductsController < ApplicationController
  before_action :set_product, except: %i[new create index]

  def index
    @categories = Category.order(name: :asc).load_async
    @products = Product.with_attached_photo.load_async
    
    if params[:category_id]
      @products = @products.where(category_id: params[:category_id])
    end
    if params[:min_price].present?
      @products = @products.where("price >= ?", params[:min_price])
    end
    if params[:max_price].present?
      @products = @products.where("price <= ?", params[:max_price])
    end
    if params[:query_text].present?
      @products = @products.search_full_text(params[:query_text])
    end
    
    order_by = Product::ORDER_BY.fetch(params[:order_by]&.to_sym, Product::ORDER_BY[:newest])
    @products = @products.order(order_by).load_async

    @pagy, @products = pagy_countless(@products, items: 12)
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
    if @product.update(secure_params)
      redirect_to products_path, notice: t('.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, notice: t('.destroyed'), status: :see_other
  end

  def edit; end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def secure_params
    params.require(:product).permit(:title, :description, :price, :photo, :category_id)
  end
end
