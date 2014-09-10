module Songify
  class Song
    attr_reader :title, :artist, :album, :id

    def initialize(title, artist, album)
      @title = title
      @artist = artist
      @album = album
      @id = nil
    end
  end
end
