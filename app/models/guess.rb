class Guess < ApplicationRecord
  belongs_to :card
  belongs_to :round
  belongs_to :user, foreign_key: :user_id
end
