require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'json'
require 'pry-byebug'

require_relative 'lib/petshopserver.rb'

# #
# This is our only html view...
#

enable :sessions

helpers do
  def get_current_user id
    user = PSS::Users.find id
    user[:cats] = PSS::Pets.adopted_by user['id'], kind: 'cats'
    user[:dogs] = PSS::Pets.adopted_by user['id'], kind: 'dogs'
    user
  end
end

before do
  if session[:user_id]
    @current_user = get_current_user session[:user_id]
  end
end

get '/' do
  erb :index
end

# #
# ...the rest are JSON endpoints
#
get '/shops' do
  headers['Content-Type'] = 'application/json'
  all_shops = PSS::Shops.all
  all_shops.to_json
end

post '/signin' do
  params = JSON.parse request.body.read

  username = params['username']
  password = params['password']

  user = PSS::Users.find_by_username username
  if password == user['password']
    headers['Content-Type'] = 'application/json'
    session[:user_id] = user['id']
    user[:cats] = PSS::Pets.adopted_by user['id'], kind: 'cats'
    user[:dogs] = PSS::Pets.adopted_by user['id'], kind: 'dogs'
    user.delete('password')
    user.to_json
  else
    status 401
  end
end

 # # # #
# Pets #
# # # #
get '/shops/:id/cats' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  all_cats = PSS::Pets.find_by_shop_id(id, kind: 'cats') || []
  all_cats.to_json
end

put '/shops/:shop_id/cats/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  PSS::Pets.update_status id, @current_user['id'], kind: 'cats'
end


 # # # #
# Pets #
# # # #
get '/shops/:id/dogs' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  all_dogs = PSS::Pets.find_by_shop_id(id, kind: 'dogs') || []
  all_dogs.to_json
end

put '/shops/:shop_id/dogs/:id/adopt' do
  headers['Content-Type'] = 'application/json'
  id = params[:id]
  PSS::Pets.update_status id, @current_user['id'], kind: 'dogs'
end
