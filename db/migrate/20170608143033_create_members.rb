class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.references :group_id, null: false
      t.references :user_id, null: false
      t.timestamps
    end
  end
end
