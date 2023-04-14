class User < ApplicationRecord
  validates :email, uniqueness: {case_sensitive: false}, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :password, presence: true, length: { in: 6..20 }
  
  has_secure_password
  after_create :generate_token, :generate_password_reset_token

  scope :filter_by_account_status, -> (account_status) { where account_status: account_status }
  scope :admin, -> { where admin: true }
  scope :trader, -> { where admin: false }
  
  def random_string
    (0...50).map {('a'..'z').to_a[rand(26)]}.join
  end

  def generate_token
   self.token = (0...50).map {('a'..'z').to_a[rand(26)]}.join
   
   self.save
  end

  # def update_password!(reset_password_params)
  #   if reset_password_params[:token] == password_reset_token
  #     self.password = reset_password_params[:password]
  #     self.password_confirmation = reset_password_params[:password]
  #     self.password_reset_token = nil

  #     self.save
  #   end
  # end

  # def send_reset_password_email
  #   UserNotifierMailer.send_reset_password_email(@user).deliver_later
  # end
  
  # def generate_password_reset_token
  #   self.password_reset_token = (0...50).map {('a'..'z').to_a[rand(26)]}.join
    
  #   self.save
  # end
  
  def generate_password_reset_token
    self.password_reset_token = random_string
    self.save
  end

  private
  # def user_params
  #   params.permit(:email)
  # end
  def reset_password_params
    params.permit(:email, :token, :password, :password_confirmation)
  end
end
