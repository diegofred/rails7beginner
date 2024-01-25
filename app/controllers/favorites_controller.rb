class FavoritesController < ApplicationController

    def create
        Favorite.create(product: product, user: Current.user)
        redirect_to product_path(product)
    end


   def destroy
      product.unfavorite!
        redirect_to product_path(product), status: :see_other
    end
  
    def index

    end

    private

    def product
        @product ||= Product.find(params[:product_id])
    end

    def product_params_index
        params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page, :favorites)
    end
end