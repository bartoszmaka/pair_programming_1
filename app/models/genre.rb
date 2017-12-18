class Genre < ApplicationRecord
  has_many :movie_genres
  has_many :movies, through: :movie_genres

  validates :title, length: { minimum: 3 }
end
