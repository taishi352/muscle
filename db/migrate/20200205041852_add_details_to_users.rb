class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :introduction, :text
    add_column :users, :profile_image_id, :string
    add_column :users, :exercise_rule, :text
    add_column :users, :meal_rule, :text
    add_column :users, :penalty, :text
    add_column :users, :admin, :boolean , default: false
  end
end
