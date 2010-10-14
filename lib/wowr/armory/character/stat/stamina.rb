module Wowr
  module Armory
    module Character
      module Stat
        class Stamina < Wowr::Armory::Character::Stat::Base
          attr_reader :health, :pet_bonus

          def initialize(elem)
            @base       = elem[:base].to_i
            @effective  = elem[:effective].to_i
            @health     = elem[:health].to_i
            @pet_bonus  = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
          end
        end
      end
    end
  end
end
