module Wowr
  module Armory
    module Character
      module Weapon
        class Skill
          attr_reader :rating, :value

          def initialize(elem)
            @value  = elem[:value].to_i == -1 ? nil : elem[:value].to_i
            @rating = elem[:rating].to_i
          end
        end
      end
    end
  end
end
