class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :name, null: false, default: "未設定"
      t.integer :gender, null: false, default: 0
      t.integer :age, null: false, default: 0
      t.string :introduction
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
