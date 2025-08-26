class CreateDayHabits < ActiveRecord::Migration[7.2]
  def change
    create_table :day_habits do |t|
      t.boolean :done
      t.references :habit, null: false, foreign_key: true
      t.references :day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
