module Wowr
  module Armory
    module Character
      module Weapon
        class PetBonus
          attr_reader :attack, :damage, :from_Type

          def initialize(elem)
            @attack     = elem[:attack].to_i == -1 ? nil : elem[:attack].to_i
            @damage     = elem[:damage].to_i == -1 ? nil : elem[:damage].to_i
            @from_type  = elem[:fromType] if elem[:fromType]
          end
        end
      end
    end
  end
end
