class CreateActors < ActiveRecord::Migration[5.2]
  def change
    create_table :actors do |t|
      t.string :name
      t.string :photo_url
      t.string :profile_url
      t.string :film
      t.integer :birth_day
      t.integer :birth_month

      t.timestamps
    end
  end
end
