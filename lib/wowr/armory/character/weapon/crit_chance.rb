module Wowr
  module Armory
    module Character
      module Weapon
        class CritChance
          attr_reader :percent, :plus_percent, :rating

          def initialize(elem)
            @percent      = elem[:percent].to_f
            @plus_percent = elem[:plusPercent].to_f
            @rating       = elem[:rating].to_i
          end
        end
      end
    end
  end
end
