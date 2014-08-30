class User < ActiveRecord::Base
  NAME_REGEX = /\A[A-Z][a-zA-Z]+\z/

  validates :fname, presence: true, format: { with: NAME_REGEX }
  validates :lname, presence: true, format: { with: NAME_REGEX }
  validates :email, presence: true, format: { with: /@/ }
  validates :password, presence: true, length: { in: 3..50 }
  has_secure_password

  def authenticate(supplied_password)
    user = User.find_by_email(supplied_email)
    if user && user.match_password(supplied_email)
      return user
    else
      return false
    end
  end
  
end
