class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.integer :title_id, null: false
      t.integer :year_id, null: false
      t.string :data, null: false
      t.string :location, null: false

      t.timestamps null: false
    end
  end
end
