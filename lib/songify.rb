module Songify
  # songs repo setter method
  def self.songs=(x)
    @songs_repo = x
  end

  # songs repo getter method
  def self.songs
    @songs_repo
  end
end

require_relative 'songify/entities/song.rb'
require_relative 'songify/repositories/songs.rb'

