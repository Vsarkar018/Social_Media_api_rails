class CreateConnections < ActiveRecord::Migration[6.1]
  def change
    create_table :connections do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps
    end
  end
end
