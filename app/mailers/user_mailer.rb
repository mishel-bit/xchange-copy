class UserMailer < ApplicationMailer

    def send_verification_email(user)
        @user = user
        mail( to: @user.email,
        subject: 'Xchange Email Confirmation' )
    end
    
    def send_pending_email(user)
        @user = user
        mail( to: @user.email,
        subject: 'Xchange Account Pending Approval' )
    end

    def send_approval_email(user)
        @user = user
        mail( to: @user.email,
        subject: 'Xchange Account has been approved!' )
    end

    def send_reset_password_email(user)
        @user = user
        @url  = 'http://localhost:3000/reset_password/'+@user.password_reset_token
        mail( to: @user.email,
        subject: 'Password Reset Request for Xchange' )
    end
    
end