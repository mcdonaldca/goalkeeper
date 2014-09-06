class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :action
      t.string :duration
      t.string :frequency
      t.string :charity

      t.timestamps
    end
  end
end
