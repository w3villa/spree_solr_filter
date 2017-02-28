class ToAddcolumnFilterableProperty < ActiveRecord::Migration
  def change

  	add_column :spree_properties , :filterable ,:boolean ,default: false
  end
end
