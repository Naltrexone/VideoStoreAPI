class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    rental.check_out = Date.today
    rental.due_date = rental.check_out + 7
    rental.status = "out"

    if rental.movie_avail?(rental_params[:movie_id])
      if rental.save
        render json: rental.as_json(except: [:created_at, :updated_at]), status: :ok
      else
        render json: {
          errors: rental.errors.messages
        }, status: :bad_request
      end
    else
      render json: {
        errors: "Movie not available"
      }, status: :bad_request
    end
  end

  def checkin
    rental = Rental.find_by(movie_id: rental_params[:movie_id], customer_id: rental_params[:customer_id], status: "out")
    if rental
      rental.status = "in"
      if rental.save
        render json: rental.as_json(except: [:created_at, :updated_at]), status: :ok

      else
        render json: {
          errors: rental.errors.messages
        }, status: :bad_request
      end
    else
      render json: {
        errors: "Not able to find rental"
      }, status: :not_found
    end
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id)
  end

end
