class Expense < ActiveRecord::Base
  validates :user_id, numericality: { greater_than_or_equal_to: 0 },
             presence: true
  validates :name, length: { in: 3..200 }, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 },
             presence: true
  validates :tab_id, presence: false

  belongs_to :user
end
