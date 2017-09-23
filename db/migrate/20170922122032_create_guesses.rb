class CreateGuesses < ActiveRecord::Migration[5.0]
  def change
    create_table :guesses do |t|
      t.string :user_answer
      t.integer :round_id
      t.integer :card_id
      t.boolean :correct
      t.boolean :is_first_try

      t.timestamps
    end
  end
end
