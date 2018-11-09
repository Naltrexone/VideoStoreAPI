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

    it 'returns movies sorted by the field specified' do

      get movies_path(sort: :title)
      body = JSON.parse(response.body)

      must_respond_with :success
      expect(body.first["title"]).must_equal movies(:beemovie)["title"]

      get movies_path(sort: :release_date)
      body = JSON.parse(response.body)

      must_respond_with :success
      expect(body.first["title"]).must_equal movies(:sandlot)["title"]
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
      fields = %w(available_inventory inventory overview release_date title)

      get movie_path(movies(:scream).id)
      body = JSON.parse(response.body)

      expect(body.keys.sort).must_equal fields
    end
  end

  describe "create" do
    let(:movie_data) {
      {
        title: "The Conjuring",
        overview: "Horror",
        release_date: "2015-10-02",
        inventory: "4"
      }
    }

    it "creates a new movie given valid data" do
      expect {
      post movies_path, params: movie_data
    }.must_change "Movie.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie_data[:title]
      must_respond_with :success
    end

    it "returns an error for invalid movie data" do
      # arrange
      movie_data["title"] = nil

      expect {
      post movies_path, params: { movie: movie_data }
    }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]).must_include "title"
      must_respond_with :bad_request
    end
  end
end
