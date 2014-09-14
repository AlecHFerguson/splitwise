class AddTabToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :tab_id, :integer
  end
end
