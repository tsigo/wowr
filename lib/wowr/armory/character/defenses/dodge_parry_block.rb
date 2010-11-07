module Wowr
  module Armory
    module Character
      module Defenses
        class DodgeParryBlock
          attr_reader :percent, :increase_percent, :rating

          def initialize(elem)
            @percent          = elem[:percent].to_f
            @increase_percent = elem[:increasePercent].to_f
            @rating           = elem[:rating].to_i
          end
        end
      end
    end
  end
end
