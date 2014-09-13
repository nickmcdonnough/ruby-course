require './server'
Songify::Repositories::Songs.new('songify_dev')
run Songify::Server
