module Songify
  class Song
    attr_reader :title, :artist, :album, :genre_id, :id

    def initialize(title, artist, album, genre_id)
      @title = title
      @artist = artist
      @album = album
      @genre_id = genre_id
      @id = nil
    end
  end
end
