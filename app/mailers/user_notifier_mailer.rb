class UserNotifierMailer < ApplicationMailer
    default :from => 'xchange.stock@zohomail.com'

    def send_signup_email(user)
        @user = user
        mail( :to => @user.email,
        :subject => 'Thanks for signing up' )
    end
end
