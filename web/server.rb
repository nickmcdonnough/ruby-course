require 'sinatra'
require 'sinatra/reloader'
require 'pry-byebug'
require_relative '../lib/songify.rb'

class Songify::Server < Sinatra::Application

  # if using vagrant uncomment the following 3 lines
  # configure do
  #   set :bind, '0.0.0.0'
  # end

  # index
  get '/' do
    erb :index, :locals => {title: 'Nick\'s Song Manager'}
  end

  ########################################################
  # All endpoints for the 'song' resource
  ########################################################

  # show
  get '/songs' do
    songs = Songify.songs.all
    erb :songs, :locals => {
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
    erb :new_song, :locals => {title: 'New Song | NSM'}
  end
  
  # create
  post '/songs' do
    song = Songify::Song.new(params['title'], params['artist'], params['album'])
    Songify.songs.save(song)
    redirect to '/songs/' + song.id.to_s
  end
  
  # delete
  get '/songs/delete/:id' do
    Songify.songs.delete(params[:id])
    redirect to '/songs'
  end

  ########################################################
  # All endpoints for the 'genre' resource
  ########################################################

  # show
  get '/genres' do
    genres = Songify.genres.all
    erb :genres, :locals => {
      title: 'All Genres | NSM',
      genres: genres
    }
  end

  # show
  get '/genres/:id' do
    genre = Songify.genres.find(params[:id])
    erb :genre, :locals => {
      title: 'Song: ' + genre.name + ' | NSM',
      genre: genre
    }
  end

  # new
  get '/genres/new' do
    erb :new_genre, :locals => {title: 'New Genre | NSM'}
  end

  # create
  post '/genres' do
    genre = Songify::Genre.new(params['name'])
    Songify.genres.save(genre)
    redirect to '/genres/' + song.id.to_s
  end

  # delete
  get '/genres/delete/:id' do
    Songify.genres.delete(params[:id])
    redirect to '/genres'
  end

  ########################################################
  # Endpoints for working with songs and genres
  ########################################################

end
