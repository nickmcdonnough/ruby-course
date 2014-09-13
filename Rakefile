namespace :db do

  task :create do
    puts `createdb songify_test`
    puts `createdb songify_dev`
    puts "Databases created."
  end

  task :migrate do
    require './lib/songify.rb'
    Songify::Repos.adapter = 'songify_test'
    Songify::Repos.build_tables
    Songify::Repos.adapter = 'songify_dev'
    Songify::Repos.build_tables
    puts "Databases migrated."
  end

  task :drop do
    puts `dropdb songify_test`
    puts `dropdb songify_dev`
    puts "Databases dropped."
  end

end

task :console do
  require './lib/songify.rb'
  require 'irb'
  ARGV.clear
  IRB.start
end
