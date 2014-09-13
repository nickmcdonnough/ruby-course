module Songify
  def self.songs=(x)
    @songs_repo = x
  end

  def self.songs
    @songs_repo
  end

  def self.genres=(x)
    @genres_repo = x
  end

  def self.genres
    @genres_rep
  end
end

require_relative 'songify/entities/song.rb'
require_relative 'songify/entities/genre.rb'

require_relative 'songify/repositories/repo.rb'
require_relative 'songify/repositories/songs.rb'
require_relative 'songify/repositories/genres.rb'

