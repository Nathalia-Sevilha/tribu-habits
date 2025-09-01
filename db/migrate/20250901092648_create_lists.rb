class CreateLists < ActiveRecord::Migration[7.2]
  def change
    create_table :lists do |t|
      t.string :title
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end
  end
end
