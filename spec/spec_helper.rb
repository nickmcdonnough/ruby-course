require_relative '../lib/songify.rb'

# next line establishes the db connection
Songify::Repos.adapter = 'songify_test'

# the next two lines assign the repositories
Songify.songs = Songify::Repos::Songs.new
Songify.genres = Songify::Repos::Genres.new
Songify.artists = Songify::Repos::Artists.new

RSpec.configure do |config|
  config.before(:each) do
    Songify::Repos.drop_tables
    Songify::Repos.build_tables
  end
end
