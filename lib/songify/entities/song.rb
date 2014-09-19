module Songify
  class Song
    attr_reader :title, :artist_id, :album, :genre_id, :id
    attr_accessor :artist, :genre

    def initialize(title, artist_id, album, genre_id)
      @title = title
      @artist_id = artist_id
      @album = album
      @genre_id = genre_id
      @id = nil
    end
  end
end
