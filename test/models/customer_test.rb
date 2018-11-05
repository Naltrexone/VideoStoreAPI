require "test_helper"

describe Customer do
  let(:customer) { customers(:bob) }

 describe "it tests the validity" do
  it "checks validity when all fields are present" do
    result = customer.valid?
    result.must_equal true
  end

  it "raises error if name not present" do
    customer.name = nil
    result = customer.valid?
    result.must_equal false
    customer.errors.messages.must_include :name
 end

  it "raises error if registered date is not present" do
    customer.registered_at = nil
    result = customer.valid?
    result.must_equal false
    customer.errors.messages.must_include :registered_at
 end

  it "raises error if address is not present" do
    customer.address = nil
    result = customer.valid?
    result.must_equal false
    customer.errors.messages.must_include :address
  end

  it "raises error if city is not present" do
    customer.address = nil
    result = customer.valid?
    result.must_equal false
    customer.errors.messages.must_include :address
  end

  it "raises error if state is not present" do
    customer.state = nil
    result = customer.valid?
    result.must_equal false
    customer.errors.messages.must_include :state
  end

  it "raises error if postal_code is not present" do
    customer.postal_code = nil
    result = customer.valid?
    result.must_equal false
    customer.errors.messages.must_include :postal_code
  end

  it "raises error if phone is not present" do
    customer.phone = nil
    result = customer.valid?
    result.must_equal false
    customer.errors.messages.must_include :phone
  end

 end

 describe "it tests relationships" do
   it "has many rentals" do
     rentals = customer.rentals.count
     rentals.must_equal 2
   end
 end
end
