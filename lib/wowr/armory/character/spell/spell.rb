module Wowr
  module Armory
    module Character
      module Spell
        # Decided to do funky stuff to the XML to make it more useful.
        # instead of having two seperate lists of bonusDamage and critChance
        # merged it into one set of objects for each thing
        class Spell
          attr_reader :arcane, :fire, :frost, :holy, :nature, :shadow,
                      :hit_rating, :bonus_healing, :penetration, :mana_regen, :speed

          def initialize(elem)
            @arcane = Wowr::Classes::SpellDamage.new(elem%'bonusDamage'%'arcane', elem%'critChance'%'arcane')
            @fire   = Wowr::Classes::SpellDamage.new(elem%'bonusDamage'%'fire', elem%'critChance'%'fire')
            @frost  = Wowr::Classes::SpellDamage.new(elem%'bonusDamage'%'frost', elem%'critChance'%'frost')
            @holy   = Wowr::Classes::SpellDamage.new(elem%'bonusDamage'%'holy', elem%'critChance'%'holy')
            @nature = Wowr::Classes::SpellDamage.new(elem%'bonusDamage'%'nature', elem%'critChance'%'nature')
            @shadow = Wowr::Classes::SpellDamage.new(elem%'bonusDamage'%'shadow', elem%'critChance'%'shadow')

            @bonus_healing  = (elem%'bonusHealing')[:value].to_i # is this right??
            @penetration    = (elem%'penetration')[:value].to_i
            @hit_rating     = Wowr::Classes::WeaponHitRating.new(elem%'hitRating')
            @mana_regen     = Wowr::Classes::ManaRegen.new(elem%'manaRegen')
            @speed      = Wowr::Classes::SpellSpeed.new(elem%'hasteRating')

            # elements = %w[arcane fire frost holy nature shadow]
            # elements.each do |element|
            #   # TODO: is this a good idea?
            #   #instance_variable_set("@#{element}", foo) #??
            #   #eval("@#{element} = SpellDamage.new(elem[:bonusDamage][element][:value], elem[:critChance][element][:percent]).to_f)")
            #   # eval("@#{element} = SpellDamage.new((elem%'bonusDamage'%element)[:value].to_i,
            #   #                                             (elem%'critChance'%element)[:percent].to_f)")
            # end
          end
        end
      end
    end
  end
end
