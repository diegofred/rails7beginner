class UsersController < ApplicationController
    skip_before_action :authenticate_user

    def show
        @user = User.find_by!(username: params[:username])
        @pagy, @products = pagy_countless(FindProducts.new.call({ user_id: @user.id }).load_async, items: 12)
    end

end