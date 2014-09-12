class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :user_id
      t.string :name
      t.text :description
      t.decimal :amount

      t.timestamps
    end
  end
end
