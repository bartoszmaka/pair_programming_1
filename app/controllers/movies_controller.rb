class MoviesController < ApplicationController
  def index
    genres = Genre.all
    q = Movie.ransack(params[:q])
    movies = q.result
    render locals: { q: q, movies: movies, genres: genres }
  end

  def show
    movie = Movie.find(params[:id])
    render locals: { movie: movie }
  end
end
