class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string     :body
      t.string     :image
      t.references :group
      t.references :user
      t.timestamps
    end
    add_index :messages, :body
    add_foreign_key :messages, :groups, column: :group_id
    add_foreign_key :messages, :users, column: :user_id
  end
end
