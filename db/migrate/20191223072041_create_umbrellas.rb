class CreateUmbrellas < ActiveRecord::Migration[5.2]
  def change
    create_table :umbrellas do |t|
      t.integer :user_id, null: false
      t.boolean :have_umbrella, null: false, default: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
