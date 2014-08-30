class Password < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :password_digest, :password
    end
  end
end
