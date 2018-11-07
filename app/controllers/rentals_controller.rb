class RentalsController < ApplicationController
  def checkout
    rental = Rental.new(rental_params)
    rental.due_date = rental.check_out + 7
    rental.status = "out"

    if rental.save
      render json: rental.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: {
        errors: rental.errors.messages
      }, status: :bad_request
    end
  end

  def checkin
    rental = Rental.new(rental_params)
    rental.due_date = nil
    rental.status = "in"

    if rental.save
      render json: rental.as_json(except: [:created_at, :updated_at]), status: :ok
    else
      render json: {
        errors: rental.errors.messages
      }, status: :bad_request
    end
  end

  private

  def rental_params
    params.permit(:movie_id, :customer_id, :check_out)
  end

end
