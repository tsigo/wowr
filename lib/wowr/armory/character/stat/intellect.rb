module Wowr
  module Armory
    module Character
      module Stat
        class Intellect < Wowr::Armory::Character::Stat::Base
          attr_reader :mana, :crit_hit_percent, :pet_bonus

          def initialize(elem)
            @base             = elem[:base].to_i
            @effective        = elem[:effective].to_i
            @mana             = elem[:mana].to_i
            @crit_hit_percent = elem[:critHitPercent].to_f
            @pet_bonus        = elem[:petBonus].to_i == -1 ? nil : elem[:petBonus].to_i
          end
        end
      end
    end
  end
end
