module Wowr
  module Armory
    module Character
      # = PVP
      #
      # Represents a <tt>characterTab/pvp</tt> element
      #
      # == Relevant XML example:
      #
      #   <pvp>
      #     <lifetimehonorablekills value="9178"/>
      #     <arenacurrency value="0"/>
      #   </pvp>
      class Pvp
        # @return [Intenger]
        attr_reader :lifetime_honorable_kills

        # @return [Intenger]
        attr_reader :arena_currency

        # @param [Hpricot::Elem] elem pvp element
        def initialize(elem)
          @lifetime_honorable_kills = (elem%'lifetimehonorablekills')[:value].to_i
          @arena_currency           = (elem%'arenacurrency')[:value].to_i
        end
      end
    end
  end
end
