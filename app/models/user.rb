class User < ApplicationRecord
  has_many :rounds
  has_many :guesses, through: :rounds
  has_many :decks, through: :rounds
end
