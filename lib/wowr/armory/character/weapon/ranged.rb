module Wowr
  module Armory
    module Character
      module Weapon
        # <ranged>
        #   <weaponSkill rating="0" value="-1"/>
        #   <damage dps="0.0" max="0" min="0" percent="0" speed="0.00"/>
        #   <speed hastePercent="0.00" hasteRating="0" value="0.00"/>
        #   <power base="57" effective="57" increasedDps="4.0" petAttack="-1.00" petSpell="-1.00"/>
        #   <hitRating increasedHitPercent="0.00" value="0"/>
        #   <critChance percent="0.92" plusPercent="0.00" rating="0"/>
        # </ranged>
        class Ranged
          attr_reader :weapon_skill, :damage, :speed, :power,
                      :hit_rating, :crit_chance

          def initialize(elem)
            @weapon_skill = Wowr::Classes::WeaponSkill.new(elem%'weaponSkill')
            @damage       = Wowr::Classes::WeaponDamage.new(elem%'damage')
            @speed        = Wowr::Classes::WeaponSpeed.new(elem%'speed')
            @power        = Wowr::Classes::WeaponPower.new(elem%'power')
            @hit_rating   = Wowr::Classes::WeaponHitRating.new(elem%'hitRating')
            @crit_chance  = Wowr::Classes::WeaponCritChance.new(elem%'critChance')
          end
        end
      end
    end
  end
end
