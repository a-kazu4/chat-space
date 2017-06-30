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
  end
end
