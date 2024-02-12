class FavoritesController < ApplicationController

    def create
        product.favorite!
        respond_to do |format|
          format.html do
            redirect_to product_path(product)
          end
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: { product: product })
          end
        end
    end


    def destroy
        product.unfavorite!
        respond_to do |format|
            format.html do
                redirect_to product_path(product), status: :see_other
            end
            format.turbo_stream do
                render turbo_stream: turbo_stream.replace("favorite", partial: "products/favorite", locals: { product: product })
            end
        end
    end
  
    def index

    end

    private

    def product
        @product ||= Product.find(params[:product_id] || params[:id])
    end

    def product_params_index
        params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page, :favorites)
    end
end