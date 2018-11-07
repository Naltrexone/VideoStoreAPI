class CustomersController < ApplicationController
  def index
    customers = Customer.all
    array = []
    customers.each do |customer|
    hash = {}
    hash = {id: customer.id,
                  name: customer.name,
                  registered_at: customer.registered_at,
                  postal_code: customer.postal_code,
                  phone: customer.phone,
                  movies_checked_out_count: customer.movies_checked_out_count
                }
    array << hash
    #render json: customers.as_json(only: [:id, :name, :registered_at, :postal_code, :phone])
  end
  render json: array.as_json
 end
end
