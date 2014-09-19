require 'pry-byebug'

module Songify
  module Repos
    class Genres
      def all
        result = Songify::Repos.adapter.exec("SELECT * FROM genres;")
        result.map { |row| build_genre(row) }
      end

      def find(id)
        sql = 'SELECT * FROM genres WHERE id = $1;'
        result = Songify::Repos.adapter.exec(sql, [id])

        if result.first
          build_genre(result.first)
        else
          nil
        end
      end

      def find_by_name(name)
        sql = 'SELECT * FROM genres WHERE name = $1;'
        result = Songify::Repos.adapter.exec(sql, [name])

        if result.first
          build_genre(row)
        else
          nil
        end
      end

      def save(genre)
        sql = %q[
          INSERT INTO genres (name)
          VALUES ($1)
          RETURNING id;
        ]
        result = Songify::Repos.adapter.exec(sql, [genre.name])
        genre.instance_variable_set :@id, result.first['id'].to_i
      end

      def delete(id)
        Songify::Repos.adapter.exec('DELETE FROM genres WHERE id = $1', [id])
      end

      def build_genre(data)
        genre = Songify::Genre.new(data['name'])
        genre.instance_variable_set :@id, data['id'].to_i
        genre
      end
    end
  end
end
