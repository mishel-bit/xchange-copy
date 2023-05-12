class SessionController < ApplicationController
    skip_before_action :authenticate_user
    layout 'session', only: [:sign_in, :new_session]
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
        end
        if @user.password.nil?
            @user.errors.add(:password,"can't be blank")
        end
        @valid_user = User.find_by(email: user_params[:email])
        if @valid_user && @valid_user.authenticate(user_params[:password])
            cookies.encrypted[:authorization] = @valid_user.token
            cookies.encrypted[:user_id] = @valid_user.email
            if @valid_user.email_confirmed 
                redirect_to root_path
            else
                redirect_to verify_path
            end
        else
            @user.errors.add(:email,"/ Password is invalid")  
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
