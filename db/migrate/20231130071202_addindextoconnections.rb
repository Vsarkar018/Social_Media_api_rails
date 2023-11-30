class Addindextoconnections < ActiveRecord::Migration[6.1]
  def change
    add_index :connections, :follower_id
    add_index :connections, :following_id
  end
end
