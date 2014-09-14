require './server'

# establish connection to development database
Songify::Repos.adapter = 'songify_dev'

# assign repos
Songify.songs = Songify::Repos::Songs.new
Songify.genres = Songify::Repos::Genres.new

# run web app
run Songify::Server
