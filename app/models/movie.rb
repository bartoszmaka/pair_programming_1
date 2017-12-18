class Movie < ApplicationRecord
  has_many :movie_genres
  has_many :genres, through: :movie_genres

  validates :title, length: { minimum: 3 }

  scope :of_genre, ->(id) { joins(:movie_genres).where(movie_genres: { genre_id: id}) }
end
