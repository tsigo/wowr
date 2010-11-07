module Wowr
  module Armory
    module Character
      module Defenses
        class Defense
          attr_reader :value, :increase_percent, :decrease_percent, :plus_defense, :rating

          def initialize(elem)
            @value            = elem[:value].to_i
            @increase_percent = elem[:increasePercent].to_f
            @decrease_percent = elem[:decreasePercent].to_f
            @plus_defense     = elem[:plusDefense].to_i
            @rating           = elem[:rating].to_i
          end
        end
      end
    end
  end
end
