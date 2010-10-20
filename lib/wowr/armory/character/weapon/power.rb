module Wowr
  module Armory
    module Character
      module Weapon
        class Power
          attr_reader :base, :effective, :increased_dps, :pet_attack, :pet_spell, :haste_rating

          def initialize(elem)
            @base           = elem[:base].to_i
            @haste_rating   = elem[:effective].to_i
            @increased_dps  = elem[:increasedDps].to_f
            @pet_attack     = (elem[:petAttack].to_f == -1 ? nil : elem[:petAttack].to_f)
            @pet_spell      = (elem[:petSpell].to_f == -1 ? nil : elem[:petSpell].to_f)
          end
        end
      end
    end
  end
end
