class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :tab_id

      t.belongs_to :tab
      t.timestamps
    end
  end
end
