module Wowr
  module Armory
    module Character
      module Defenses
        class Resilience
          attr_reader :damage_percent, :hit_percent, :value

          def initialize(elem)
            @damage_percent = elem[:damagePercent].to_f
            @hit_percent    = elem[:hitPercent].to_f
            @value          = elem[:value].to_f
          end
        end
      end
    end
  end
end
