require 'rails_helper'

RSpec.describe Genre, type: :model do
  it 'belongs_to many movies' do
    movie1 = Movie.create(title: 'the rspec')
    movie2 = Movie.create(title: 'the factorygirl')
    genre = Genre.create(title: 'rspecy')

    genre.movies = [movie1, movie2]
    genre.save

    expect(genre.valid?).to be true
  end
end
