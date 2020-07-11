class AddcollumsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :age, :integer
    add_column :users, :gender, :integer
    add_column :users, :introduction, :string
    add_column :users, :area, :string
    add_column :users, :have_umbrella, :boolean
    add_column :users, :image, :text
    add_column :users, :removing, :boolean
  end
end
