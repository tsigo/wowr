module Wowr
  module Armory
    module Character
      module Stat
        class Strength < Wowr::Armory::Character::Stat::Base
          attr_reader :attack, :block

          def initialize(elem)
            @base       = elem['base'].to_i
            @effective  = elem['effective'].to_i
            @attack     = elem['attack'].to_i
            @block      = elem['block'].to_i == -1 ? nil : elem['block'].to_i
          end
        end
      end
    end
  end
end
