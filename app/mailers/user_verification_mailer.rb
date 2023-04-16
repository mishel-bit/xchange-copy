class UserVerificationMailer < ApplicationMailer
    default :from => 'xchange.stocks@zohomail.com'

    def send_verification_email(user)
        @user = user
        mail( to: @user.email,
        subject: 'Xchange Email Confirmation' )
    end

end
