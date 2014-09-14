class Tab < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :expenses
end
