require './server'
Songify::Repos.adapter = 'songify_dev'
run Songify::Server
