class AddColumnLocations < ActiveRecord::Migration
  def change
    add_column :locations, :isocode, :string, null: false
  end
end
