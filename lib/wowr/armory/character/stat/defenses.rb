module Wowr
  module Armory
    module Character
      module Stat
        class Defenses
          attr_reader :armor, :defense, :dodge, :parry, :block, :resilience

          def initialize(elem)
            # TODO: Clean this namespace up
            @armor      = Wowr::Armory::Character::Defenses::Armor.new(elem%'armor')
            @defense    = Wowr::Armory::Character::Defenses::Defense.new(elem%'defense')
            @dodge      = Wowr::Armory::Character::Defenses::DodgeParryBlock.new(elem%'dodge')
            @parry      = Wowr::Armory::Character::Defenses::DodgeParryBlock.new(elem%'parry')
            @block      = Wowr::Armory::Character::Defenses::DodgeParryBlock.new(elem%'block')
            @resilience = Wowr::Armory::Character::Defenses::Resilience.new(elem%'resilience')
          end
        end
      end
    end
  end
end
