class UserController < ApplicationController
  skip_before_action :authenticate_user
  
  #get /sign_up
  def sign_up
    @user = User.new
  end

  #post /sign_up
  def new_account
    @user = User.new(email: sign_up_params[:email], password: sign_up_params[:password])
    if @user.save
        if sign_up_params[:password_confirmation].empty?
            @user.errors.add(:password,"confirmation can't be blank")
        else
            if @user.valid?
                @user.save
                UserNotifierMailer.send_signup_email(@user).deliver
                cookies.encrypted[:authorization] = @user.token
                redirect_to root_path
            else
                @user.errors.add(:password,"not equal")  
            end  
        end
    end
    render :sign_up, status: :unprocessable_entity if @user.errors.count > 0
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation) 
  end
end
