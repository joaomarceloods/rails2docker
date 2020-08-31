class ProductsController < ApplicationController
  before_action :set_products

  def index
    @new_product = Product.new
  end

  def create
    @new_product = Product.new(product_params)
    @new_product.save!
    redirect_to products_url
  rescue ActiveRecord::RecordInvalid
    render :index
  end

  private

  def set_products
    @products = Product.all
  end

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
