class User < ActiveRecord::Base
  validates :fname, presence: true
  validates :lname, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
