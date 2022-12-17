class UsersController < ApplicationController
    def index
        @users = all_users
    end

    def show
        @user = User.includes(:posts).find(params[:id])
    end
end
