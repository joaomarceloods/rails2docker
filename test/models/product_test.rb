require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "name can't be blank" do
    p = Product.new(name: nil).tap(&:validate)
    assert_includes p.errors[:name], "can't be blank"
  end

  test "price must be greater than 0" do
    p = Product.new(price: 0).tap(&:validate)
    assert_includes p.errors[:price], "must be greater than 0"
  end
end
