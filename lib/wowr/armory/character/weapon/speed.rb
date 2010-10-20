module Wowr
  module Armory
    module Character
      module Weapon
        class Speed
          attr_reader :haste_percent, :haste_rating, :value

          def initialize(elem)
            @haste_percent  = elem[:hastePercent].to_f
            @haste_rating   = elem[:hasteRating].to_f
            @value        = elem[:value].to_f
          end
        end
      end
    end
  end
end
