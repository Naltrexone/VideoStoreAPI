require "test_helper"

describe CustomersController do
 describe "tests the index method" do
  it "returns an Array" do
    # Act
    get customers_path

    # Convert the JSON response into a Hash
    body = JSON.parse(response.body)

    # Assert
    expect(body).must_be_kind_of Array
  end

  it "returns all of the customers" do
    # Act
    get customers_path

    # Convert the JSON response into a Hash
    body = JSON.parse(response.body)

    # Assert
    expect(body.length).must_equal Customer.count
  end

  it "returns customers with exactly the required fields" do
    keys = %w(id name phone postal_code registered_at)

    # Act
    get customers_path

    # Convert the JSON response into a Hash
    body = JSON.parse(response.body)

    # Assert that each
    body.each do |customer|
      expect(customer.keys.sort).must_equal keys
      expect(customer.keys.length).must_equal keys.length
    end
  end
end
end
