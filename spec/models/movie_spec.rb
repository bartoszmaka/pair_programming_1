require 'rails_helper'

RSpec.describe Movie, type: :model do
  it 'belongs_to many movies' do
    genre1 = Genre.create(title: 'rspecy')
    genre2 = Genre.create(title: 'cucumber')
    movie = Movie.create(title: 'FactoryGirl on Ice')

    movie.genres = [genre1, genre2]
    movie.save

    expect(movie.valid?).to be true
  end
end
