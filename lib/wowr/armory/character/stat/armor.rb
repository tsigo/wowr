module Wowr
  module Armory
    module Character
      module Stat
        class Armor < Wowr::Armory::Character::Stat::Base
          attr_reader :percent, :pet_bonus

          def initialize(elem)
            @base       = elem[:base].to_i
            @effective  = elem[:effective].to_i
            @percent    = elem[:percent].to_f
            @pet_bonus  = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
          end
        end
      end
    end
  end
end
