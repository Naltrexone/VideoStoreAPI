require "test_helper"

describe MoviesController do

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
      post movies_path, params: { movie: movie_data }
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
