require "test_helper"

describe Rental do
  let(:rental) { rentals(:one) }

  describe 'validations' do
    it "must be valid" do
      value(rental).must_be :valid?
    end

    it 'has required fields' do
      fields = [:movie_id, :customer_id, :check_out, :due_date, :status]

      fields.each do |field|
        expect(rental).must_respond_to field
      end
    end

    it 'must have a check_out date' do
      rental.check_out = nil
      valid = rental.save

      expect(valid).must_equal false
      expect(rental.errors.messages).must_include :check_out
    end

    it 'must have a due date' do
      rental.due_date = nil
      valid = rental.save

      expect(valid).must_equal false
      expect(rental.errors.messages).must_include :due_date
    end

    it 'must have a status' do
      rental.status = nil
      valid = rental.save

      expect(valid).must_equal false
      expect(rental.errors.messages).must_include :status
    end
  end

  describe 'relationships' do
    it 'belongs to a movie' do
      movie = rental.movie

      expect(movie).must_be_instance_of Movie
      expect(movie.id).must_equal rental.movie_id
    end

    it 'belongs to a customer' do
      customer = rental.customer

      expect(customer).must_be_instance_of Customer
      expect(customer.id).must_equal rental.customer_id
    end
  end
end
