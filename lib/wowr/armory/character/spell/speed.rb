module Wowr
  module Armory
    module Character
      module Spell
        class Speed
          attr_reader :percent_increase, :haste_rating

          def initialize(elem)
            @percent_increase = elem[:hastePercent].to_f
            @haste_rating   = elem[:hasteRating].to_i
          end
        end
      end
    end
  end
end
