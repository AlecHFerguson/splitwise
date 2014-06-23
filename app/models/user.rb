class User < ActiveRecord::Base

  before_save :encrypt_password
  after_save :clear_password

  validates :fname, presence: true, format: { with: /\A[a-zA-Z]+\z/ }
  validates :lname, presence: true, format: { with: /\A[a-zA-Z]+\z/ }
  validates :email, presence: true, format: { with: /@/ }
  validates :password, presence: true, length: { in: 3..50 }

  def self.authenticate(supplied_email, supplied_password)
    user = User.find_by_email(supplied_email)
    if user && user.match_password(supplied_email)
      return user
    else
      return false
    end
  end

  def match_password(supplied_password)
    password == BCrypt::Engine.hash_secret(supplied_password, salt)
  end
  
  def encrypt_password
    self.salt = BCrypt::Engine.generate_salt
    self.password = BCrypt::Engine.hash_secret(password, salt)
  end

  def clear_password
    self.password = nil
  end
end
