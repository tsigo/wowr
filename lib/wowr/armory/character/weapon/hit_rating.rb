module Wowr
  module Armory
    module Character
      module Weapon
        class HitRating
          attr_reader :increased_hit_percent, :value, :armor_penetration

          def initialize(elem)
            @armor_penetration = elem[:penetration].to_f
            @increased_hit_percent  = elem[:increasedHitPercent].to_f
            @value                  = elem[:value].to_f
          end
        end
      end
    end
  end
end
