require 'sinatra'
require 'sinatra/reloader'
require 'pry-byebug'
require_relative 'lib/songify.rb'

class Songify::Server < Sinatra::Application

  # if using vagrant uncomment the following 3 lines
  # configure do
  #   set :bind, '0.0.0.0'
  # end

  # index
  get '/' do
    redirect to '/index'
  end
  
  get '/index' do
    erb :index, :locals => {title: 'Nick\'s Song Manager'}
  end
  
  # show
  get '/songs' do
    songs = Songify.songs.all
    erb :show, :locals => {
      title: 'All Songs | NSM',
      songs: songs
    }
  end
  
  # show
  get '/songs/:id' do
    song = Songify.songs.find(params[:id])
    erb :song, :locals => {
      title: 'Song: ' + song.title + ' | NSM',
      song: song
    }
  end
  
  # new
  get '/songs/new' do
    erb :new, :locals => {title: 'New Song | NSM'}
  end
  
  # create
  post '/songs/create' do
    song = Songify::Song.new(params['title'], params['artist'], params['album'])
    Songify.songs.save(song)
    redirect to '/songs/show/' + song.id.to_s
  end
  
  # delete
  get '/songs/delete/:id' do
    Songify.songs.delete(params[:id])
    redirect to '/songs/show'
  end
end
