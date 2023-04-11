class UserNotifierMailer < ApplicationMailer
    default :from => 'xchange.your.stock@gmail.com'

    def send_signup_email(user)
        @user = user
        mail( :to => @user.email,
        :subject => 'Thanks for signing up' )
    end
end
