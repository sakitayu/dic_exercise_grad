class AddcollumsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, null: false, default: "未設定"
    add_column :users, :age, :integer, null: false, default: 6
    add_column :users, :gender, :integer, null: false, default: 3
    add_column :users, :introduction, :string
    add_column :users, :area, :string, null: false, default: "未入力"
    add_column :users, :have_umbrella, :boolean, default: false
  end
end
