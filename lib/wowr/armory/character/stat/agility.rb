module Wowr
  module Armory
    module Character
      module Stat
        class Agility < Wowr::Armory::Character::Stat::Base
          attr_reader :armor, :attack, :crit_hit_percent

          def initialize(elem)
            @base             = elem[:base].to_i
            @effective        = elem[:effective].to_i
            @armor            = elem[:armor].to_i
            @attack           = elem[:attack].to_i == -1 ? nil : elem[:attack].to_i
            @crit_hit_percent = elem[:critHitPercent].to_f
          end
        end
      end
    end
  end
end
