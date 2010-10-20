module Wowr
  module Armory
    module Character
      module Spell
        class ManaRegen
          attr_reader :casting, :not_casting

          def initialize(elem)
            @casting      = elem[:casting].to_f
            @not_casting  = elem[:notCasting].to_f
          end
        end
      end
    end
  end
end
