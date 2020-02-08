class CreateScorings < ActiveRecord::Migration[5.2]
  def change
    create_table :scorings do |t|
      t.integer :exercise_result, default: 0
      t.boolean :meal_result, default: false
      t.datetime :start_time

      t.timestamps
    end
  end
end
