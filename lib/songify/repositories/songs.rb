module Songify
  module Repos
    class Songs
      def build_song(data)
        title, artist = data['title'], data['artist']
        album, genre_id = data['album'], data['genre_id']
        x = Songify::Song.new(title, artist, album, genre_id)
        x.instance_variable_set :@id, data['id'].to_i
        x
      end

      # parameter could be song id
      def find(id)
        result = Songify::Repos.adapter.exec(%q[
          SELECT * FROM songs
          WHERE id = $1
        ], [id])

        build_song(result.first)
      end

      # no parameter needed
      def all
        result = Songify::Repos.adapter.exec("SELECT * FROM songs")
        result.map { |r| build_song(r) }
      end

      # old save a song method
      # parameter should be a song object
      # def save_a_song(song)
      #   result = Songify::Repos.adapter.exec(%q[
      #     INSERT INTO songs (title, artist, album)
      #     VALUES ($1, $2, $3)
      #     RETURNING id
      #   ], [song.title, song.artist, song.album])

      #   song.instance_variable_set :@id, result.first['id'].to_i
      # end

      def save(*songs)
        base = "INSERT INTO songs (title, artist_id, album, genre_id) values "
        values = songs.map do |s|
          "('#{s.title}', '#{s.artist_id}', '#{s.album}', #{s.genre_id})"
        end
        sql = base + values.join(', ') + " RETURNING id"
        puts sql
        result = Songify::Repos.adapter.exec(sql)
        songs.each_with_index do |song, i|
          song.instance_variable_set :@id, result[i]['id'].to_i
        end
      end

      # parameter could be song id
      def delete(id)
        Songify::Repos.adapter.exec(%q[
          DELETE FROM songs
          WHERE id = $1
        ], [id])
      end

      # Songs by genre
      def find_by_genre(id)
        sql = 'SELECT * FROM songs WHERE genre_id = $1'
        result = Songify::Repos.adapter.exec(sql, [id])
        result.map { |row| build_song(row) }
      end
    end
  end
end



