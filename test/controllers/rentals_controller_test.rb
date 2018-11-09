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
end
