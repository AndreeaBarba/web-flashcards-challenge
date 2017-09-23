class CreateRounds < ActiveRecord::Migration[5.0]
  def change
    create_table :rounds do |t|
      t.integer :user_id
      t.integer :deck_id
      t.integer :guess_count

      t.timestamps
    end
  end
end
