class User < ApplicationRecord
  has_many :rounds
  has_many :guesses, through: :rounds
  has_many :decks, through: :rounds
  validates :password, presence: true, length: { minimum: 6}
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def encrypted_password
    @encrypted_password ||= BCrypt::Password.new(password)
  end

  def encrypted_password=(new_password)
    @encrypted_password = BCrypt::Password.create(new_password)
    self.password = @encrypted_password
  end

  def authenticate(password)
    self.password == password
  end
end
