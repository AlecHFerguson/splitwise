
class Tab < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :expenses
  has_many :participants

  def this_tabs_expenses
    @this_tabs_expenses ||= this_tabs_expenses!
  end

  def this_tabs_expenses!
    @this_tabs_expenses = Expense.where(tab_id: self.id)
  end

  def this_tabs_users
    @this_tabs_users ||= this_tabs_users!
  end

  def this_tabs_users!
    @this_tabs_users = User.joins('INNER JOIN participants ON participants.user_id = users.id').where(participants: { tab_id: self.id })
  end

  def total_amount
    @total_amount ||= total_amount!
  end

  def total_amount!
    @total_amount = 0
    this_tabs_expenses!.each do |e|
      @total_amount += e.amount
    end
    return @total_amount
  end
end
