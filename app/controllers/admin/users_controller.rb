module Admin
  class UsersController < ApplicationController
    before_action :get_user

    def index
      @users = User.all
      @users = @users.filter_by_account_status(params[:account_status]) if params[:account_status].present?
    end

    def show
      @user = User.find(params["id"])
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path
      else 
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @user = User.find(params["id"])
    end

    def update
      @user = User.find(params["id"])
      if @user.update(user_params)
        redirect_to admin_users_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user = User.find(params["id"])
      @user.destroy
      redirect_to admin_users_path
    end

    def user_params
      params.require(:user).permit(:email,:password,:account_status)
    end

    private
    
    def get_user
        @user = User.find_by_email(cookies.encrypted[:user_id])
        print @user.inspect
       
        if !@user.admin?
           redirect_to root_path
        end
    end
  end
end
