require "test_helper"

describe Customer do
  let(:bob) { Customer.new }

 describe "it tests the validity" do
  it "raises error is name not present" do
    bob.name = nil
    result = bob.valid?
    result.must_equal false
  end
 end

 describe "it tests relationships" do

 end
end
