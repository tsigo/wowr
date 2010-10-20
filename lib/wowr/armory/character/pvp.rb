module Wowr
  module Armory
    module Character
      # Player-versus-player data
      class Pvp
        attr_reader :lifetime_honorable_kills, :arena_currency

        def initialize(elem)
          @lifetime_honorable_kills = (elem%'lifetimehonorablekills')[:value].to_i
          @arena_currency           = (elem%'arenacurrency')[:value].to_i
        end
      end
    end
  end
end
