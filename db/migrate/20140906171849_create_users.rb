class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :first
      t.string :last
      t.date :birthday
      t.string :gender

      t.timestamps
    end
  end
end
