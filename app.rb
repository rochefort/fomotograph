require "sinatra"
require_relative "models/product"

get '/' do
  # HOME LANDING PAGE SHOWING BANNER PHOTO, TITLE, AND SUBTITLE
  erb "<!DOCTYPE html>
  <html>
  <head>
    <title>Fomotograph | Home </title>
    <link rel='stylesheet' type='text/css' href='<%= url('/style.css') %>'>
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:400,500,600' rel='stylesheet' type='text/css'>
  </head>

  <body>

    <div id='container'>

      <div id='header'>
        <a href='/'><img src='/logo-black-text.png' alt='logo image' class='logo'/></a>
        <a href='/team' class='nav'>Team</a>
        <a href='/products' class='nav'>Products</a>
      </div>

      <div id='main'>
        <img src='hero.png' alt='hero image' class='hero'/>
        <img src='logo-white.png' alt='logo image' class='logo'/>
        <h1 id='site-title'>Fomotograph</h1>
        <h2 id='site-subtitle'>Custom travel photos on demand</h2>
        <a class='button' href='/products'>Get Started</a>
      </div>

      <div id='footer'>
        © Fomotograph
      </div>

    </div>

  </body>
  </html>"
end


get '/team' do
  # TEAM PAGE LISTING THE TEAM MEMBERS
  erb "<!DOCTYPE html>
  <html>
  <head>
    <title>Fomotograph | The Team </title>
    <link rel='stylesheet' type='text/css' href='<%= url('/style.css') %>'>
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:400,500,600' rel='stylesheet' type='text/css'>
  </head>

  <body>

    <div id='container'>

      <div id='header'>
        <a href='/'><img src='/logo-black-text.png' alt='logo image' class='logo'/></a>
        <a href='/team' class='nav'>Team</a>
        <a href='/products' class='nav'>Products</a>
      </div>

      <div id='main'>
        <h1>The Team</h1>
        <div id='wrapper'>

        <div class='staff'>
          <img src='/founder.png' alt='founder' class='small-thumb' />
          <p class='employee'>Hezekiah | Founder</p>
          <p class='bio'>Hezekiah was drinking kombucha out of his favorite Hans
          Solo coffee mug when he realized that he’s actually pretty decent at
          Photoshop! In his spare time, he likes to immerse himself in virtual
          reality while riding his hoverboard backwards.</p>
        </div>

        </div>
      </div>

      <div id='footer'>
        © Fomotograph
      </div>

    </div>

  </body>
  </html>"
end

get '/products' do
  @products = Product.all
  # PRODUCTS PAGE LISTING ALL THE PRODUCTS
  erb "<!DOCTYPE html>
  <html>
  <head>
  <title>Fomotograph | All Products </title>
  <link rel='stylesheet' type='text/css' href='<%= url('/style.css') %>'>
  <link href='https://fonts.googleapis.com/css?family=Work+Sans:400,500,600' rel='stylesheet' type='text/css'>
  </head>

  <body>

    <div id='container'>

      <div id='header'>
        <a href='/'><img src='/logo-black-text.png' alt='logo image' class='logo'/></a>
        <a href='/team' class='nav'>Team</a>
        <a href='/products' class='nav'>Products</a>
      </div>

      <div id='main'>
        <h1> All Products </h1>
        <div id='wrapper'>

          <% @products.each do |product| %>
          <a href='/products/location/<%= product['location'] %>'>
          <div class='product'>
            <div class='thumb'>
              <img src='<%= procuct['url'] %>' />
            </div>
            <div class='caption'>
              <%= product['location'] != 'us' ? product['location'].capitalize : product['location'].upcase %>
            </div>
          </div>
          </a>
          <% end %>

        </div>
      </div>

      <div id='footer'>
        © Fomotograph
      </div>

    </div>

  </body>
  </html>"
end

get '/products/location/:location' do
  @products = Product.find_by_location(params[:location])
  # PAGE DISPLAYING ALL PHOTOS FROM ONE LOCATION
  erb "<!DOCTYPE html>
  <html>
  <head>
    <title>Fomotograph | <%= params[:location] != 'us' ? params[:location].capitalize : params[:location].upcase %> </title>
    <link rel='stylesheet' type='text/css' href='<%= url('/style.css') %>'>
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:400,500,600' rel='stylesheet' type='text/css'>
  </head>

  <body>

    <div id='container'>

      <div id='header'>
        <a href='/'><img src='/logo-black-text.png' alt='logo image' class='logo'/></a>
        <a href='/team' class='nav'>Team</a>
        <a href='/products' class='nav'>Products</a>
      </div>

      <div id='main'>

        <h1> <%= params[:location] != 'us' ? params[:location].capitalize : params[:location].upcase %> </h1>
        <div id='wrapper'>

        <% @products.each do |product| %>
          <a href='/products/<%= product['id'] %>'>
          <div class='product'>
            <div class='thumb'>
              <img src='<%= product['url'] %>' />
            </div>
            <div class='caption'>
              <%= product['title'] %>
            </div>
          </div>
          </a>
        <% end %>

        </div>
        <a class='small-button' href='/products'> View All Products </a>
      </div>

      <div id='footer'>
        © Fomotograph
      </div>

    </div>

  </body>
  </html>"
end

get '/products/:id' do
  DATA = HTTParty.get("https://fomotograph-api.udacity.com/products.json")["photos"]
  @product = Product.find(params[:id])
  # PAGE DISPLAYING ONE PRODUCT WITH A GIVEN ID
  erb "<!DOCTYPE html>
  <html>
  <head>
    <title>Fomotograph | <%= @product['title'] %> </title>
    <link rel='stylesheet' type='text/css' href='<%= url('/style.css') %>'>
    <link href='https://fonts.googleapis.com/css?family=Work+Sans:400,500,600' rel='stylesheet' type='text/css'>
  </head>

  <body>

    <div id='container'>

      <div id='header'>
        <a href='/'><img src='/logo-black-text.png' alt='logo image' class='logo'/></a>
        <a href='/team' class='nav'>Team</a>
        <a href='/products' class='nav'>Products</a>
      </div>

      <div id='main'>
        <h1><%= @product['title'] %></h1>
        <a class='small-button' href='#'>Fomotograph Me!</a>
        <p class='summary'> <%= @product['summary'] %> </p>
        <p class='summary'>Order your prints today for $<%= @product['price'] %></p>
        <img class='full' src='<%= @product['url'] %>' />
        <a class='small-button' href='/products/location/<%= @product['location'] %>'> View All <%= @product['location'] != 'us' ? @product['location'].capitalize : @product['location'].upcase %> Products </a>
      </div>

      <div id='footer'>
        © Fomotograph
      </div>

    </div>

  </body>
  </html>"
end
