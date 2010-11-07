module Wowr
  module Armory
    module Character
      class Resistance
        attr_reader :value, :pet_bonus

        def initialize(elem)
          @value      = elem[:value].to_i
          @pet_bonus  = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
        end
      end
    end
  end
end
