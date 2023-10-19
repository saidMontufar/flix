class ReviewsController < ApplicationController

  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end

  def new
    @reviews = @movie.reviews.new
  end

  def create
    @reviews = @movie.reviews.new(review_params)

    if @reviews.save
      redirect_to movie_reviews_path(@movie),
       notice: "Review was succesfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).
      permit(:name, :stars, :comment)
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
