class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.integer :user_id, null: false
      t.string :area, null: false, default: "未入力"
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
