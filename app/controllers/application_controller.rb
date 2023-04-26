class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

    before_action :authenticate_user, except: [:routes]

    def root
    end 

    def current_user
        token = cookies.encrypted[:authorization]

        if token.present?
            user ||= User.find_by(token: token.gsub("Token", ""))
            cookies.encrypted[:user_id] = user.email
            user
        end
    end

    def authenticate_user
        if current_user.nil?
            redirect_to sign_in_path
        else
            @user = current_user
        end
    end

    def restrict_users
        if !@user.email_confirmed?
            redirect_to verify_path
        end
        if @user.account_status ==="pending"
            redirect_to account_path
        end
    end

    def restrict_admin
        if @user.admin?
            redirect_to admin_users_path
        end
    end

    def restrict_user
        if !@user.admin?
            redirect_to root_path
        end
    end
end
