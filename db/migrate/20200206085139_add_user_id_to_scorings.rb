class AddUserIdToScorings < ActiveRecord::Migration[5.2]
  def change
    add_column :scorings, :user_id, :integer
  end
end
