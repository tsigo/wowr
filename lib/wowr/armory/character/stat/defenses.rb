module Wowr
  module Armory
    module Character
      module Stat
        class Defenses
          attr_reader :armor, :defense, :dodge, :parry, :block, :resilience

          def initialize(elem)
            @armor      = Armor.new(elem%'armor')
            @defense    = Defense.new(elem%'defense')
            @dodge      = DodgeParryBlock.new(elem%'dodge')
            @parry      = DodgeParryBlock.new(elem%'parry')
            @block      = DodgeParryBlock.new(elem%'block')
            @resilience = Resilience.new(elem%'resilience')
          end
        end
      end
    end
  end
end
