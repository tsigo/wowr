module Wowr
  module Armory
    module Character
      # Larger group of factions
      # Used for faction information
      # eg Alliance, Shattrath City, Steamwheedle Cartel
      class RepFactionCategory
        attr_reader :key, :name, :factions
        alias_method :to_s, :name

        def initialize(elem)
          @key  = elem[:key]
          @name = elem[:name]

          @factions = {}
          (elem/:faction).each do |faction|
            @factions[faction[:key]] = RepFaction.new(faction)
          end
        end

        def total
          total = 0
          factions.each_value { |faction| total += faction.reputation }
          return total
        end
      end
    end
  end
end
