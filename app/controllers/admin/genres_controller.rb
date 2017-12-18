class Admin::GenresController < ApplicationController
  before_action :authorize_user

  def new
    genre = Genre.new
    render locals: { genre: genre }
  end

  def edit
    genre = Genre.find(params[:id])
    render locals: { genre: genre }
  end

  def create
    if Genre.create(genre_attribuets)
      redirect_to genres_path, success: 'created'
    else
      render 'new'
    end
  end

  def update
    genre = Genre.find(params[:id])
    if genre.update(genre_attribuets)
      redirect_to genre, success: 'updated'
    else
      render 'edit'
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    if genre.destroy
      redirect_to genres_path, success: 'deleted'
    else
      redirect_to genres_path, danger: 'could not delete'
    end
  end

  private

  def genre_attribuets
    params.require(:genre).permit(:title)
  end
end
