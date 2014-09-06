class CreateAtoms < ActiveRecord::Migration
  def change
    create_table :atoms do |t|
      t.boolean :completed
      t.string :month
      t.integer :day
      t.integer :year
      t.boolean :ignore
      t.boolean :success
      t.string :proof
      t.text :note
      t.timestamp :posted_at
      t.integer :goal_id

      t.timestamps
    end
  end
end
