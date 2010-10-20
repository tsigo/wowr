module Wowr
  module Armory
    module Character
      module Spell
        class Damage
          attr_reader :value, :crit_chance_percent
          alias_method :percent, :crit_chance_percent

          def initialize(bonusDamage_elem, critChance_elem)
            @value    = bonusDamage_elem[:value].to_i
            @crit_chance_percent  = critChance_elem[:percent].to_f
          end
        end
      end
    end
  end
end
