require 'pg'

module Songify
  module Repos
    def self.adapter=(dbname)
      @__db_conn = PG.connect(host:'localhost', dbname: dbname)
    end

    def self.adapter
      @__db_conn
    end

    def self.build_tables
      table_query = <<-SQL
        CREATE TABLE IF NOT EXISTS artists(
          id serial UNIQUE,
          name text
        );
        CREATE TABLE IF NOT EXISTS genres(
          id serial UNIQUE,
          name text
        );
        CREATE TABLE IF NOT EXISTS songs(
          id serial,
          title text,
          artist_id int references artists(id),
          album text,
          genre_id int references genres(id)
        );
      SQL
      @__db_conn.exec(table_query)
    end

    def self.drop_tables
      @__db_conn.exec(%q[
        DROP TABLE IF EXISTS songs;
        DROP TABLE IF EXISTS genres;
        DROP TABLE IF EXISTS artists;
      ])
    end
  end
end

