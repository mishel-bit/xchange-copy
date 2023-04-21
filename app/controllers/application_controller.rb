class ApplicationController < ActionController::Base
 protect_from_forgery with: :null_session

 before_action :authenticate_user

 def root
 end 

 def current_user
    token = cookies.encrypted[:authorization]

    if token.present?
        user ||= User.find_by(token: token.gsub("Token", ""))
        cookies.encrypted[:user_id] = user.email
    end
 end

 def authenticate_user
     if current_user.nil?
         redirect_to sign_in_path
     end
 end
 
end
