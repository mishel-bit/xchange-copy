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
                UserNotifierMailer.send_signup_email(@user).deliver_later
                cookies.encrypted[:authorization] = @user.token
                redirect_to root_path
            else
                @user.errors.add(:password,"not equal")  
            end  
        end
    end
    render :sign_up, status: :unprocessable_entity if @user.errors.count > 0
  end

  #get /forgot_password
  def forgot_password
    @user = User.new
  end
  #post /forgot_password
  def password_reset_email
    if user = User.find_by(email: sign_up_params[:email])
      UserResetPasswordMailer.send_reset_password_email(user).deliver_later
      redirect_to forgot_password_path, notice: 'A password resend link has been sent to your email'
    else
      render json: { error: 'not found'}, status: 404
    end
  end
  # get '/reset_password/:token
  def reset_password
    @user = User.find_by_password_reset_token(params[:token])
  end
   # post '/reset_password/:token
  def update_password
    if @user = User.find_by_password_reset_token(params[:token])
      if @user.update(sign_up_params)
        redirect_to reset_password_path, notice: 'Password reset successful'
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end



  private
  def password_params
    params.permit(:password, :password_confirmation) 
  end
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation) 
  end


end
