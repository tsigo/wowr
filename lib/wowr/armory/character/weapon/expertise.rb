module Wowr
  module Armory
    module Character
      module Weapon
        # <expertise additional="0" percent="0.00" rating="0" value="0"/>
        class Expertise
          attr_reader :additional, :percent, :rating, :value

          def initialize(elem)
            @additional = elem[:additional].to_i
            @percent    = elem[:percent].to_f
            @rating     = elem[:rating].to_i
            @value      = elem[:value].to_i
          end
        end
      end
    end
  end
end
