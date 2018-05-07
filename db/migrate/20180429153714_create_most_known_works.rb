class CreateMostKnownWorks < ActiveRecord::Migration[5.2]
  def change
    create_table :most_known_works do |t|
      t.string :title
      t.string :url
      t.float :rating
      t.string :director
      t.integer :actor_id
      t.timestamps
    end
  end
end
