class ExpensesBelongsToUsers < ActiveRecord::Migration
  def change
    change_table :expenses do |t|
      t.rename :user_id, :user_id_old
    end
    change_table :expenses do |t|
      t.belongs_to :user
    end
  end
end
