require 'pry-byebug'

module Songify
  module Repos
    class Artists
      def all
        result = Songify::Repos.adapter.exec("SELECT * FROM artists;")
        result.map { |row| build_artist(row) }
      end

      def find(id)
        sql = 'SELECT * FROM artists WHERE id = $1;'
        result = Songify::Repos.adapter.exec(sql, [id])

        if result.first
          build_artist(result.first)
        else
          nil
        end
      end

      def find_by_name(name)
        sql = 'SELECT * FROM artists WHERE name = $1;'
        result = Songify::Repos.adapter.exec(sql, [name])

        if result.first
          build_artist(row)
        else
          nil
        end
      end

      def save(artist)
        sql = %q[
          INSERT INTO artists (name)
          VALUES ($1)
          RETURNING id;
        ]
        result = Songify::Repos.adapter.exec(sql, [artist.name])
        artist.instance_variable_set :@id, result.first['id'].to_i
      end

      def delete(id)
        Songify::Repos.adapter.exec('DELETE FROM artists WHERE id = $1', [id])
      end

      def build_artist(data)
        artist = Songify::Artist.new(data['name'])
        artist.instance_variable_set :@id, data['id'].to_i
        artist
      end
    end
  end
end
