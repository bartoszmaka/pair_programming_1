class Admin::MoviesController < ApplicationController
  before_action :authorize_user

  def new
    genres = Genre.all
    movie = Movie.new
    render locals: { genres: genres, movie: movie }
  end

  def edit
    genres = Genre.all
    movie = Movie.find(params[:id])
    render locals: { genres: genres, movie: movie }
  end

  def create
    # binding.pry
    if Movie.create(movie_attributes)
      redirect_to movies_path, success: 'created'
    else
      render 'edit'
    end
  end

  def update
    movie = Movie.find(params[:id])
    if movie.update(movie_attribuets)
      redirect_to movie, success: 'updated'
    else
      redirect_to movies_path, danger: 'could not update'
    end
  end

  def destroy
    movie = Movie.find(params[:id])
    if movie.destroy
      redirect_to movies_path, success: 'deleted'
    else
      redirect_to movies_path, danger: 'could not delete'
    end
  end

  private

  def movie_attributes
    params.require(:movie).permit(:title, :description, genre_ids: [])
  end
end

