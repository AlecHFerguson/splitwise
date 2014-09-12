class Expense < ActiveRecord::Base
  validates :user_id, presence: true
  validates :name, length: { in: 3..200 }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end