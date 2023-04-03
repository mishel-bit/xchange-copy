class User < ApplicationRecord
  validates :email, uniqueness: {case_sensitive: false}, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :password, presence: true, length: { in: 6..20 }
  
  has_secure_password
  after_create :generate_token

 

  def generate_token
   self.token = (0...50).map {('a'..'z').to_a[rand(26)]}.join
   
   self.save
  end
end
