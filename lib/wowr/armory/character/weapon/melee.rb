module Wowr
  module Armory
    module Character
      module Weapon
        # <melee>
        #   <mainHandDamage dps="65.6" max="149" min="60" percent="0" speed="1.60"/>
        #   <offHandDamage dps="0.0" max="0" min="0" percent="0" speed="2.00"/>
        #   <mainHandSpeed hastePercent="0.00" hasteRating="0" value="1.60"/>
        #   <offHandSpeed hastePercent="0.00" hasteRating="0" value="2.00"/>
        #   <power base="338" effective="338" increasedDps="24.0"/>
        #   <hitRating increasedHitPercent="0.00" value="0"/>
        #   <critChance percent="4.16" plusPercent="0.00" rating="0"/>
        #   <expertise additional="0" percent="0.00" rating="0" value="0"/>
        # </melee>
        class Melee
          attr_reader :main_hand_skill, :off_hand_skill,
                      :main_hand_damage, :off_hand_damage,
                      :main_hand_speed, :off_hand_speed,
                      :power, :hit_rating, :crit_chance,
                      :expertise

          def initialize(elem)
            # TODO: Do these not exist anymore?
            @main_hand_skill  = Wowr::Classes::WeaponSkill.new(elem%'mainHandWeaponSkill') if (elem%'mainHandWeaponSkill')
            @off_hand_skill   = Wowr::Classes::WeaponSkill.new(elem%'offHandWeaponSkill') if (elem%'offHandWeaponSkill')

            @main_hand_damage = Wowr::Classes::WeaponDamage.new(elem%'mainHandDamage')
            @off_hand_damage  = Wowr::Classes::WeaponDamage.new(elem%'offHandDamage')

            @main_hand_speed  = Wowr::Classes::WeaponSpeed.new(elem%'mainHandSpeed')
            @off_hand_speed   = Wowr::Classes::WeaponSpeed.new(elem%'offHandSpeed')

            @power            = Wowr::Classes::WeaponPower.new(elem%'power')
            @hit_rating       = Wowr::Classes::WeaponHitRating.new(elem%'hitRating')
            @crit_chance      = Wowr::Classes::WeaponCritChance.new(elem%'critChance')

            @expertise        = Wowr::Classes::WeaponExpertise.new(elem%'expertise')
          end
        end
      end
    end
  end
end
