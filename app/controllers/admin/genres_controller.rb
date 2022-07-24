class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
     @admin = current_admin
     @genres = Genre.all
     @genre = Genre.new
  end

  def create
     @genres = Genre.all
     @genre = Genre.new(genre_params)
     if @genre.save
       redirect_to admin_genres_path(@genre)
     else
       render :index
     end
  end

  def edit
     @genre = Genre.find(params[:id])
  end


  def update
     @genre = Genre.find(params[:id])
     if @genre.update(genre_params)
        redirect_to admin_genres_path
     else
        render :edit
     end
  end


  def genre_params
    params.require(:genre).permit(:name)
  end


end
