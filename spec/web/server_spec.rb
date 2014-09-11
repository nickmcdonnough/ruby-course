require 'server_spec_helper'
require 'pry-byebug'

describe Songify::Server do

  def app
    Songify::Server.new
  end

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

  describe 'get /songs' do
    context 'when there are no songs saved' do
      it 'receives \'no songs\' message' do
        get '/songs'
        expect(last_response.body).to include 'No songs'
      end
    end

    context 'when there are songs saved' do
      it 'can view all songs' do
        song = Songify::Song.new('Percolator', 'Cajmere', 'Percolator EP')
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
    xit 'can save songs' do
      post '/songs', {} # params hash
      song_list = Songify.songs.all
      expect(song_list.count).to eq(3)
    end
  end

  describe 'get /songs/delete' do
    xit 'can delete saved songs by id' do
      song_list = Songify.songs.all
      expect(song_list.count).to eq(2)
    end
  end
end
