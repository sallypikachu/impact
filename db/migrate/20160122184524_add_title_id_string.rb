class AddTitleIdString < ActiveRecord::Migration
  def change
    add_column :titles, :value, :string, null: false
  end
end
