module Wowr
  module Armory
    module Character
      module Weapon
        class Damage
          attr_reader :dps, :max, :min, :percent, :speed

          def initialize(elem)
            @dps      = elem[:dps].to_f
            @max      = elem[:max].to_i
            @min      = elem[:min].to_i
            @percent  = elem[:percent].to_f
            @speed  = elem[:speed].to_f
          end
        end
      end
    end
  end
end
