class User < ApplicationRecord
  validates :email, uniqueness: {case_sensitive: false}, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :password, presence: true, length: { in: 6..20 }, unless: -> { password.blank? }
  
  has_secure_password
  after_create :generate_token, :generate_password_reset_token, :generate_email_token

  scope :filter_by_account_status, -> (account_status) { where account_status: account_status }
  scope :admin, -> { where admin: true }
  scope :trader, -> { where admin: false }
  
  def random_string
    (0...50).map {('a'..'z').to_a[rand(26)]}.join
  end

    
  def random_six_digits
    rand.to_s[2..7]
  end

  def generate_token
   self.token = random_string
   
   self.save
  end
  
  def generate_email_token
    self.token = random_string
    
    self.save
   end

   def generate_verification_code
    self.verification_code = random_six_digits
    
    self.save
   end
   
   
  def generate_password_reset_token
    self.password_reset_token = random_string
    self.save
  end

  private

  def reset_password_params
    params.permit(:email, :token, :password, :password_confirmation)
  end
end
