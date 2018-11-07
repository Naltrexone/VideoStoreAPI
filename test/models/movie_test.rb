require "test_helper"

describe Movie do
  let(:movie) { movies(:scream) }

  describe 'validations' do
    it 'must be valid' do
      expect(movie).must_be :valid?
    end

    it 'has required fields' do
      fields = [:title, :overview, :release_date, :inventory]

      fields.each do |field|
        expect(movie).must_respond_to field
      end
    end

    it 'must have a title' do
      movie.title = nil
      valid = movie.save

      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :title
    end

    it 'must have an overview' do
      movie.overview = nil
      valid = movie.save

      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :overview
    end

    it 'must have a release date' do
      movie.release_date = nil
      valid = movie.save

      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :release_date
    end

    it 'must have an integer for inventory' do
      movie.inventory = "two"
      valid = movie.save

      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :inventory
    end

    it 'must have an integer that is greater than 0' do
      movie.inventory = -1
      valid = movie.save

      expect(valid).must_equal false
      expect(movie.errors.messages).must_include :inventory
    end
  end

  describe 'relationships' do
    it 'can have many rentals' do
      num_rentals = movie.rentals.count

      expect(num_rentals).must_equal 2
    end

    it 'can have zero rentals' do
      movie = movies(:sandlot)
      num_rentals = movie.rentals.count

      expect(num_rentals).must_equal 0
    end
  end

  describe 'available_inventory' do
    it 'can calculate available_inventory for movie' do
      movie = movies(:scream)
      avail_inv = movie.available_inventory

      expect(avail_inv).must_equal 0
    end

    it 'can calculate available_inventory for movie that has not been rented' do
      movie = movies(:sandlot)
      avail_inv = movie.available_inventory

      expect(avail_inv).must_equal movie.inventory
    end
  end
end
