class SessionController < ApplicationController
    skip_before_action :authenticate_user

    #get /sign_in
    def sign_in
        if !cookies.encrypted[:authorization]
            @user = User.new
        else
            redirect_to root_path
        end
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
                cookies.encrypted[:authorization] = @user.token
                cookies.encrypted[:user_id] = @user.email
                if @user.email_confirmed 
                    redirect_to root_path
                else
                    redirect_to verify_path
                end
            else
                @user.errors.add(:email,"/ Password is invalid")
            end                
        end
        render :sign_in, status: :unprocessable_entity if @user.errors.count > 0
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

end
