require 'pg'
require 'pry-byebug'

module Songify
  module Repositories
    class Songs
      def initialize
        @db = PG.connect(host:'localhost', dbname:'songify')
        build_table
      end

      def build_table
        @db.exec(%q[
          CREATE TABLE IF NOT EXISTS songs(
            id serial,
            title text,
            artist text,
            album text
          )
        ])
      end

      def drop_table
        @db.exec("DROP TABLE songs")
        build_table
      end

      # parameter could be song id
      def find(id)
        result = @db.exec(%q[
          SELECT * FROM songs
          WHERE id = $1
        ], [id])

        build_song(result.first)
      end

      # no parameter needed
      def all
        result = @db.exec("SELECT * FROM songs")
        result.map { |r| build_song(r) }
      end

      # old save a song method
      # parameter should be a song object
      # def save_a_song(song)
      #   result = @db.exec(%q[
      #     INSERT INTO songs (title, artist, album)
      #     VALUES ($1, $2, $3)
      #     RETURNING id
      #   ], [song.title, song.artist, song.album])

      #   song.instance_variable_set :@id, result.first['id'].to_i
      # end

      def save(*songs)
        base = "INSERT INTO songs (title, artist, album) values "
        values = songs.map do |s|
          "('#{s.title}', '#{s.artist}', '#{s.album}')"
        end
        sql = base + values.join(', ') + " RETURNING id"
        result = @db.exec(sql)
        songs.each_with_index do |song, i|
          song.instance_variable_set :@id, result[i]['id'].to_i
        end
      end

      # parameter could be song id
      def delete(id)
        @db.exec(%q[
          DELETE FROM songs
          WHERE id = $1
        ], [id])
      end

      def build_song(data)
        x = Songify::Song.new(data['title'], data['artist'], data['album'])
        x.instance_variable_set :@id, data['id'].to_i
        x
      end
    end
  end
end



