class UserPendingMailer < ApplicationMailer
    default :from => 'xchange.stocks@zohomail.com'
    
    def send_pending_email(user)
        @user = user
        mail( to: @user.email,
        subject: 'Xchange Account Pending Approval' )
    end
end