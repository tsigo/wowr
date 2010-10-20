module Wowr
  module Armory
    module Character
      # Smaller NPC faction that is part of a FactionCategory
      # eg Darnassus, Argent Dawn
      class RepFaction
        attr_reader :key, :name, :reputation
        alias_method :to_s, :name
        alias_method :to_i, :reputation

        alias_method :rep, :reputation

        def initialize(elem)
          @key        = elem[:key]
          @name       = elem[:name]
          @reputation = elem[:reputation].to_i
        end
      end
    end
  end
end
