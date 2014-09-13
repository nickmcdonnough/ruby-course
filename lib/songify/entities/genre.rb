module Songify
  class Genre
    attr_reader :name, :id

    def initialize(name)
      @name = name
      @id = nil
    end
  end
end
