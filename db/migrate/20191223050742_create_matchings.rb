class CreateMatchings < ActiveRecord::Migration[5.2]
  def change
    create_table :matchings do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :matchings, :follower_id
    add_index :matchings, :followed_id
    add_index :matchings, [:follower_id, :followed_id], unique: true
  end
end
