require "test_helper"

describe MoviesController do

  describe "index" do
    it "is a real working route" do
      get movies_path
      must_respond_with :success
    end

    it "returns json" do
      get movies_path
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "returns an Array" do
      get movies_path
      body = JSON.parse(response.body)

      body.must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_path

      body = JSON.parse(response.body)
      body.length.must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      fields = %w(id release_date title)
      get movies_path
      body = JSON.parse(response.body)

      body.each do |movie|
        movie.keys.sort.must_equal fields
      end
    end
  end

  describe "show" do
    it "can get a movie" do
      get movie_path(movies(:scream).id)
      must_respond_with :success
    end

    it "responds with 404 not_found for nonexisting movie" do
      id = -1
      get movie_path(id)

      must_respond_with :not_found
    end

    it "returns movie with the required fields" do
      fields = %w(inventory overview release_date title)

      get movie_path(movies(:scream).id)
      body = JSON.parse(response.body)

      expect(body.keys.sort).must_equal fields
    end
  end
end
