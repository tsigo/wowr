module Wowr
  module Armory
    module Character
      # Second stat bar, depends on character class
      class SecondBar
        attr_reader :effective, :casting, :not_casting, :type

        def initialize(elem)
          @effective    = elem[:effective].to_i
          @casting      = elem[:casting].to_i == -1 ? nil : elem[:casting].to_i
          @not_casting  = elem[:notCasting].to_i == -1 ? nil : elem[:notCasting].to_i
          @type         = elem[:type]
        end
      end
    end
  end
end
