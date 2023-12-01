class AddindexandFkToConnections < ActiveRecord::Migration[6.1]
  def change
    add_index :connections, :follower_id
    add_index :connections, :following_id
    add_foreign_key :connections, :users, column: :follower_id, on_delete: :cascade
    add_foreign_key :connections, :users, column: :following_id, on_delete: :cascade
  end
end
