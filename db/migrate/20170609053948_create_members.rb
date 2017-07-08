class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.references :group
      t.references :user
      t.timestamps
    end
    add_foreign_key :members, :groups, column: :group_id
    add_foreign_key :members, :users, column: :user_id
  end
end
