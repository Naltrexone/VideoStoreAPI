require "test_helper"

describe RentalsController do
  describe 'checkout' do

    let(:rental_data) {
      {
        movie_id: movies(:titanic).id,
        customer_id: customers(:tim).id
      }
    }

    it "creates a new rental given valid data" do
      expect {
        post checkout_path, params: rental_data
      }.must_change "Rental.count", 1

      rental = Rental.last

      must_respond_with :success
      expect(rental.status).must_equal "out"

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "check_out"
      expect(body).must_include "due_date"
      expect(body).must_include "status"
    end

    it 'returns bad_request for invalid customer' do
      rental_data["customer_id"] = -1

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      must_respond_with :bad_request
    end

    it 'returns bad_request for invalid movie' do
      rental_data["movie_id"] = -1

      expect {
        post checkout_path, params: rental_data
      }.wont_change "Rental.count"

      must_respond_with :bad_request
    end
  end

  describe 'checkin' do

    it "checks in a valid rental" do
      movie = movies(:scream)
      customer = customers(:bob)
      expect {
        post checkin_path, params: {customer_id: customer.id, movie_id: movie.id}
      }.wont_change "Rental.count"

      must_respond_with :success
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "status"
    end

    it "does not check in a movie if parameters are invalid" do
      movie = movies(:scream)
       expect {
        post checkin_path, params: {customer_id: -1, movie_id: movie.id}
      }.wont_change "Rental.count"

      must_respond_with :not_found
    end

    it "does not check in if parameters are missing" do
      movie = movies(:scream)
       expect {
        post checkin_path, params: {movie_id: movie.id}
      }.wont_change "Rental.count"

      must_respond_with :not_found
    end
  end
end
