class MoviesController < ApplicationController
  def index
    movies = Movie.all

    if params[:sort]
      movies = Movie.order(params[:sort])
    end

    render json: movies.as_json(only: [:id, :title, :release_date]), status: :ok
  end

  def show
    movie = Movie.find_by(id: params[:id])

    if movie.nil?
      render json: {
        errors: "not found"
      }, status: :not_found
    else
      render json: {
        title: movie.title,
        overview: movie.overview,
        release_date: movie.release_date,
        inventory: movie.inventory,
        available_inventory: movie.available_inventory
      }, status: :ok
      # render json: movie.as_json(only: [:title, :overview, :release_date, :inventory], method: :available_inventory), status: :ok
    end

  end

  def create
    movie = Movie.new(movie_params)

    if movie.save
      render json: movie.as_json(only: [:id]), status: :ok
    else
      render json: {
        errors: movie.errors.messages
      }, status: :bad_request
    end
  end

  private

  def movie_params
    params.permit(:title, :overview, :release_date, :inventory)
  end
end
