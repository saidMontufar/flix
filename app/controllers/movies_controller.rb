class MoviesController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]


  def index
    case params[:filter]
    when "recent"
      @movies = Movie.recent
    when "upcoming"
      @movies = Movie.upcoming
    else
      @movies = Movie.released
    end
  end

  def show

    @fans = @movie.fans
    @genres = @movie.genres.order(:name)
    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def edit

  end

  def update

    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie was successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie was successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy

    @movie.destroy
    redirect_to root_url, status: :see_other,
      alert: "Movie was succesfylly deleted!"
  end


private
  def movie_params
    params.require(:movie).
      permit(:title, :description, :rating, :released_on, :total_gross,
        :director, :duration, :main_image, genre_ids: [])
  end

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])

  end
end
