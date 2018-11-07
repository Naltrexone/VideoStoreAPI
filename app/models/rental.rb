class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie

  def movie_avail?(movie_id)
    movie = Movie.find_by(id: movie_id)
    if movie.available_inventory > 0
      return true
    else
      return false
    end
  end

end
