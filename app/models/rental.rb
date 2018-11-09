class Rental < ApplicationRecord
  validates :check_out, presence: true
  validates :due_date, presence: true
  validates :status, presence: true

  belongs_to :customer
  belongs_to :movie

  def movie_avail?(movie_id)
    movie = Movie.find_by(id: movie_id)
    
    if movie.nil?
      return false
    elsif movie.available_inventory > 0
      return true
    else
      return false
    end
  end
end
