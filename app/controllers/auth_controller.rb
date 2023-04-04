class AuthController < ApplicationController
 skip_before_action :authenticate_user

 #get /sign_in
 def sign_in
     if !cookies.encrypted[:authorization]
         @user = User.new
     else
         redirect_to root_path
     end
 end
 #get /sign_up
 def sign_up
     @user = User.new
 end
 #post /sign_in
 def new_session
     @user = User.new(email: user_params[:email], password: user_params[:password])
     if @user.email.empty?
         @user.errors.add(:email,"can't be blank")
     elsif @user.password.empty?
         @user.errors.add(:password,"can't be blank")
     else 
         @user = User.find_by(email: user_params[:email])
         if @user && @user.authenticate(user_params[:password])
         # if user #email is present and have correct password
             cookies.encrypted[:authorization] = @user.token
             redirect_to root_path
         else
             @user.errors.add(:email,"/ Password is invalid")
             # @user.errors.add(:password,"invalid")
         end                
     end
     render :sign_in, status: :unprocessable_entity if @user.errors.count > 0
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
                 UserMailer.with(user: @user).welcome_email.deliver_later
                 cookies.encrypted[:authorization] = @user.token
                #  redirect_to root_path

             else
                 @user.errors.add(:password,"not equal")  
             end  
         end
     end
     render :sign_up, status: :unprocessable_entity if @user.errors.count > 0
 end
 #delete /logout
 def logout
     cookies.delete :authorization
     cookies.delete :user_id
     redirect_to sign_in_path
 end

 private

 def user_params
     params.require(:user).permit(:email, :password)
 end

 def sign_up_params
     params.require(:user).permit(:email, :password, :password_confirmation) 
 end
end
