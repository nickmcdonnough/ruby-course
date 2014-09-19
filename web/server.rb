require 'sinatra'
require 'rack-flash'
require 'sinatra/reloader'
require 'pry-byebug'
require_relative '../lib/songify.rb'

class Songify::Server < Sinatra::Application

  #if using vagrant uncomment the line with 'set bind...'
  configure do
    # set :bind, '0.0.0.0'
    enable :sessions
    set :session_secret, '089e09w'
    use Rack::Flash
  end

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
    erb :'songs/index', :locals => {
      title: 'All Songs | NSM',
      songs: songs
    }
  end
  
  # show
  get '/songs/s/:id' do
    song = Songify.songs.find(params[:id])
    erb :'songs/show', :locals => {
      title: 'Song: ' + song.title + ' | NSM',
      song: song
    }
  end
  
  # new
  get '/songs/new' do
    genres = Songify.genres.all
    erb :'songs/new', :locals => {
      title: 'New Song | NSM',
      genres: genres
    }
  end
  
  # create
  post '/songs' do
    title, artist = params['title'], params['artist']
    album, genre_id = params['album'], params['genre']
    song = Songify::Song.new(title, artist, album, genre_id)
    Songify.songs.save(song)
    redirect to '/songs/s/' + song.id.to_s
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
    erb :'genres/index', :locals => {
      title: 'All Genres | NSM',
      genres: genres
    }
  end

  # show
  get '/genres/g/:id' do
    genre = Songify.genres.find(params[:id])
    erb :'genres/show', :locals => {
      title: 'Song: ' + genre.name + ' | NSM',
      genre: genre
    }
  end

  # new
  get '/genres/new' do
    genres = Songify.genres.all
    erb :'genres/new', :locals => {
      title: 'New Genre | NSM',
      genres: genres
    }
  end

  # create
  # notice the exception handling code here.
  # this is in case someone enteres a value
  # for a genre that already exists in the db.
  # our database is set up with a unique
  # constraint on the genres(name) column.
  post '/genres' do
    begin
      genre = Songify::Genre.new(params['name'])
      Songify.genres.save(genre)
      redirect to '/genres/g/' + genre.id.to_s
    rescue PG::Error => e
      flash[:alert] = Songify::Error.process(e)
      redirect to '/genres/new'
    end
  end

  # delete
  get '/genres/delete/:id' do
    Songify.genres.delete(params[:id])
    redirect to '/genres'
  end

  ########################################################
  # Endpoints for working with songs and genres
  ########################################################

  get '/songs/genre/:id' do
    genre = Songify.genres.find(params[:id].to_i)
    songs = Songify.songs.find_by_genre(params[:id].to_i)
    erb :'songs/index', :locals => {
      title: genre.name + ' Songs | NSM',
      songs: songs,
      genre: genre
    }
  end
end
