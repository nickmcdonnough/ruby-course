require 'server_spec_helper'
require 'pry-byebug'

describe Songify::Server do

  def app
    Songify::Server.new
  end

  #############################################
  # Basic testing of index endpoint
  #############################################
  describe 'get /' do
    it 'loads the homepage' do
      get '/'
      expect(last_response).to be_ok
    end

    it 'has proper title' do
      get '/'
      expect(last_response.body).to include 'Song Manager'
    end
  end

  #############################################
  # Testing of 'songs' resource endpoints
  #############################################
  describe 'get /songs' do
    context 'when there are no songs saved' do
      it 'receives \'no songs\' message' do
        get '/songs'
        expect(last_response.body).to include 'No songs'
      end
    end

    context 'when there are songs saved' do
      it 'can view all songs' do
        artist = Songify::Artist.new('Cajmere')
        Songify.artists.save(artist)
        genre = Songify::Artist.new('Chicago House')
        Songify.genres.save(genre)
        song = Songify::Song.new('Percolator', 1, 'Percolator EP', 1)

        Songify.songs.save(song)
        get '/songs'
        expect(last_response.body).to include 'Percolator', 'Cajmere'
      end
    end
  end

  describe 'get /songs/new' do
    it 'displays the correct form' do
      get '/songs/new'
      expect(last_response.body).to include 'form', 'action', 'method'
    end
  end

  describe 'post /songs' do
    it 'can save songs' do
      artist = Songify::Artist.new('Dustin Zahn')
      Songify.artists.save(artist)
      genre = Songify::Artist.new('Techno')
      Songify.genres.save(genre)

      song_data = {
        'title' => 'Stranger to Stability',
        'artist' => 1,
        'album' => 'Stranger',
        'genre' => 1
      }

      post '/songs', song_data # params hash
      song_list = Songify.songs.all
      expect(song_list.count).to eq(1)
    end
  end

  describe 'get /songs/delete' do
    it 'can delete saved songs by id' do
      artist = Songify::Artist.new('Dustin Zahn')
      Songify.artists.save(artist)
      genre = Songify::Artist.new('Techno')
      Songify.genres.save(genre)

      song_data = {
        'title' => 'Stranger to Stability',
        'artist' => 1,
        'album' => 'Stranger',
        'genre' => 1
      }

      post '/songs', song_data # params hash
      song_list = Songify.songs.all
      expect(song_list.count).to eq(1)

      get '/songs/delete/1'
      song_list = Songify.songs.all
      expect(song_list.count).to eq(0)
    end
  end

  #############################################
  # Testing of 'genres' resource endpoints
  #############################################

  describe 'get /genres' do
    context 'when there are no genres saved' do
      it 'receives \'no genres\' message' do
        get '/genres'
        expect(last_response.body).to include 'No genres'
      end
    end

    context 'when there are genres saved' do
      it 'can view all genres' do
        genre = Songify::Genre.new('Techno')
        Songify.genres.save(genre)
        get '/genres'
        expect(last_response.body).to include 'Techno'
      end
    end
  end

  describe 'get /genres/new' do
    it 'displays the correct form' do
      get '/genres/new'
      expect(last_response.body).to include 'form', 'action', 'method'
    end
  end

  describe 'post /genres' do
    it 'can save genres' do
      genre_data = {'title' => 'Stranger to Stability'}

      post '/genres', genre_data # params hash
      genre_list = Songify.genres.all
      expect(genre_list.count).to eq(1)
    end
  end

  describe 'get /genres/delete' do
    it 'can delete saved genres by id' do
      genre_data = {'title' => 'Stranger to Stability'}

      post '/genres', genre_data # params hash
      genre_list = Songify.genres.all
      expect(genre_list.count).to eq(1)

      get '/genres/delete/1'
      genre_list = Songify.genres.all
      expect(genre_list.count).to eq(0)
    end
  end
end
