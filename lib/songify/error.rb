module Songify
  module Error
    def self.process(error)
      case error
      when PG::ConnectionBad
        'Couldn\'t connect to database!'
      when PG::UniqueViolation
        'The genre name you entered already exists!'
      when PG::ServerError
        'There was a problem with the database!'
      end
    end
  end
end

