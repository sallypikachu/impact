class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :country, null: false
    end
    remove_column :facts, :location, :string, null: false
    add_column :facts, :location_id, :integer, null: false
  end
end
