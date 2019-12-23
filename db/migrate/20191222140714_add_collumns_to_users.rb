class AddCollumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, default: '名前未設定'
    add_column :users, :gender, :integer, default: 0
    add_column :users, :age, :integer, default: 0
    add_column :users, :profile, :string
  end
end
