module Wowr
  module Armory
    module Character
      module Stat
        class Spirit < Wowr::Armory::Character::Stat::Base
          attr_reader :health_regen, :mana_regen

          def initialize(elem)
            @base         = elem[:base].to_i
            @effective    = elem[:effective].to_i
            @health_regen = elem[:healthRegen].to_i
            @mana_regen   = elem[:manaRegen].to_i
          end
        end
      end
    end
  end
end
