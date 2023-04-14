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
                # UserNotifierMailer.with(@user).send_signup_email.deliver_later
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
      print 'check before setting password reset token'
      print user.inspect
      # user.generate_password_reset_token
      # user.generate_password_reset_token!(sign_up_params)
      print 'check after setting password reset token'
      print user.inspect
      UserResetPasswordMailer.send_reset_password_email(user).deliver_later
      
      render json: { success: 'a link is sent to your email'}, status: 200
    else
      #not found 404
      render json: { error: 'not found'}, status: 404
    end
  end
  # get '/reset_password/:token
  def reset_password
    print "check token"
    print params[:token]
    @user = User.find_by_password_reset_token(params[:token])
    # if params[:token].blank?
    #   if user = User.find_by(email: sign_up_params[:email])
    #     print 'check before setting password reset token'
    #     print user.inspect
    #     # user.generate_password_reset_token
    #     # user.generate_password_reset_token!(sign_up_params)
    #     print 'check after setting password reset token'
    #     print user.inspect
    #     UserResetPasswordMailer.send_reset_password_email(user).deliver_later
        
    #     render json: { success: 'a link is sent to your email'}, status: 200
    #   else
    #     #not found 404
    #     render json: { error: 'not found'}, status: 404
    #   end
    # else
      # if @user = User.find_by_password_reset_token(params[:token])
      #   if user = @user.update_password!(password_params)
      #     #success
      #     render json: { success: 'true'}, status: 200
      #   end
      # else
      #   #invalid token
      #   render json: { error: 'invalid token'}, status: 404
      # end
    # end
  end
   # post '/reset_password/:token
  def change_password
    if @user = User.find_by_password_reset_token(params[:token])
      if @user.update(sign_up_params)
        #success
        render json: { success: 'true'}, status: 200
      end
    else
      render :edit, status: :unprocessable_entity
      #invalid token
      # render json: { error: 'invalid token'}, status: 404
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
