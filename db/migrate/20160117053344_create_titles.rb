class CreateTitles < ActiveRecord::Migration
  def change
    create_table :titles do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
    add_index :titles, :name, unique: true
  end
end
