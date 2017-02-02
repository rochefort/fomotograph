require "sinatra"
require_relative "models/product"

helpers do
  def titlecase(title)
    title != "us" ? title.capitalize : title.upcase
  end
end

get "/" do
  @page_title = "Home"
  erb :index
end

get "/team" do
  @page_title = "The Team"
  erb :team
end

get "/products" do
  @products = Product.all
  @page_title = "All Products"
  erb :products
end

get "/products/location/:location" do
  @products = Product.find_by_location(params[:location])
  @page_title = titlecase(params[:location])
  erb :category
end

get "/products/:id" do
  @product = Product.find(params[:id])
  @page_title = @product.title
  erb :single
end
