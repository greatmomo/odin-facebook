class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests do |t|
      t.integer :requester_id
      t.integer :receiver_id
      t.string  :status

      t.timestamps
    end
  end
end
