require 'sinatra'
require 'sinatra/reloader'
require 'pry-byebug'
require_relative 'lib/songify.rb'

get '/' do
  redirect to '/index'
end

get '/index' do
  erb :index, :locals => {title: 'Nick\'s Song Manager'}
end

get '/show' do
  songs = Songify.songs.all
  erb :show, :locals => {
    title: 'All Songs | NSM',
    songs: songs
  }
end

get '/show/:id' do
  song = Songify.songs.find(params[:id])
  erb :song, :locals => {
    title: 'Song: ' + song.title + ' | NSM',
    song: song
  }
end

get '/new' do
  erb :new, :locals => {title: 'New Song | NSM'}
end

post '/create' do
  song = Songify::Song.new(params['title'], params['artist'], params['album'])
  Songify.songs.save(song)
  redirect to '/show/' + song.id.to_s
end

get '/song/delete/:id' do
  Songify.songs.delete(params[:id])
  redirect to '/show'
end
