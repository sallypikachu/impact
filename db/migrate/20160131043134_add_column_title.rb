class AddColumnTitle < ActiveRecord::Migration
  def change
    add_column :titles, :description, :text
  end
end
