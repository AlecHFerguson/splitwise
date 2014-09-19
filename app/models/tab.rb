class Tab < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :expenses
  has_many :participants

  def total_amount
    @total_amount ||= total_amount!
  end

  def total_amount!
    these_expenses = Expense.where(tab_id: self.id)
    @total_amount = 0
    these_expenses.each do |e|
      @total_amount += e.amount
    end
    return @total_amount
  end
end
