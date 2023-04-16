class UserResetPasswordMailer < ApplicationMailer
    default :from => 'xchange.stocks@zohomail.com'
    
    def send_reset_password_email(user)
        @user = user
        print 'check password reset token is set'
        print @user.inspect
        @url  = 'http://localhost:3000/reset_password/'+@user.password_reset_token
        mail( to: @user.email,
        subject: 'Password Reset Request for Xchange' )
    end
end