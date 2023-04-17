class UserApprovalMailer < ApplicationMailer
    default :from => 'xchange.stocks@zohomail.com'
    
    def send_approval_email(user)
        @user = user
        mail( to: @user.email,
        subject: 'Xchange Account has been approved!' )
    end
end