module Wowr
  module Armory
    module Character
      class Defenses
        attr_reader :armor, :defense, :dodge, :parry, :block, :resilience

        def initialize(elem)
          @armor      = DefenseStats::Armor.new(elem%'armor')
          @defense    = DefenseStats::Defense.new(elem%'defense')
          @dodge      = DefenseStats::Avoidance.new(elem%'dodge')
          @parry      = DefenseStats::Avoidance.new(elem%'parry')
          @block      = DefenseStats::Avoidance.new(elem%'block')
          @resilience = DefenseStats::Resilience.new(elem%'resilience')
        end
      end
    end
  end
end
