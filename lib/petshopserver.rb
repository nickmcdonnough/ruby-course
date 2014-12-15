require 'pg'

require_relative 'petshopserver/repos/pets.rb'
require_relative 'petshopserver/repos/shops.rb'
require_relative 'petshopserver/repos/users.rb'

module PSS
  def self.db
    PG.connect(host: 'localhost', dbname: 'petshop_db')
  end

  def self.typecast hash, key
    if hash[key] == 't'
      hash[key] = true
    else
      hash[key] = false
    end
  end
end
