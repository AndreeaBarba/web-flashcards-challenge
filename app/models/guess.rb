class Guess < ApplicationRecord
  belongs_to :card
  belongs_to :round
  belongs_to :user, through: :round
end
