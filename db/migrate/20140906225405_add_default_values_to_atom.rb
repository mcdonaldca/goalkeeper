class AddDefaultValuesToAtom < ActiveRecord::Migration
  def change
  	change_column :atoms, :completed, :boolean, :default => false
  	change_column :atoms, :success, :boolean, :default => false
  	change_column :atoms, :ignore, :boolean, :default => false
  end
end
