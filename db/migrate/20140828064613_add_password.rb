class AddPassword < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :password_digest, :password
    end
    add_column :users, :password_digest, :string
  end
end
