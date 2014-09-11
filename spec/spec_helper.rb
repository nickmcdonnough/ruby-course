require_relative '../lib/songify.rb'

Songify.songs = Songify::Repositories::Songs.new('songify_test')

RSpec.configure do |config|
  config.before(:each) do
    Songify.songs.rebuild
  end
end
