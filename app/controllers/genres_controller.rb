class GenresController < ApplicationController
  def index
    genres = Genre.all
    render locals: { genres: genres }
  end

  def show
    genre = Genre.find(params[:id])
    render locals: { genre: genre }
  end
end
