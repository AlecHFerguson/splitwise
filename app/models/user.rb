class User < ActiveRecord::Base

  before_save :encrypt_password
  after_save :clear_password

  validates :fname, presence: true
  validates :lname, presence: true
  validates :email, presence: true
  validates :password, presence: true

  
  def encrypt_password
    salt = BCrypt::Engine.generate_salt
    self.password = BCrypt::Engine.hash_secret(password, salt)
  end

  def clear_password
    self.password = nil
  end
end
