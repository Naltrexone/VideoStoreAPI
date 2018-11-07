require "test_helper"

describe Rental do
  let(:rental) { Rental.new }

  it "must be valid" do
    value(rental).must_be :valid?
  end

  describe "it tests the method that checks if movie is available" do
    it "checks if no movie is available when all are checked out" do
      movie = movies(:scream)
      answer = rental.movie_avail?(movie.id)

      expect(answer).must_equal false

    end

    it "checks that movie is available when there are more in inventory than are checked out" do
      movie = movies(:titanic)
      answer = rental.movie_avail?(movie.id)
      expect(answer).must_equal true
    end

    it "checks that movie is not available when there are none in inventory" do
      movie = movies(:beemovie)
      answer = rental.movie_avail?(movie.id)
      expect(answer).must_equal false
    end
  end
end
