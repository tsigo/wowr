module Wowr
  module Armory
    module ArenaTeam
      # = Emblem
      #
      # Represents an arena team's <tt>emblem</tt> element
      #
      # == Relevant XML example:
      #
      #   <emblem background="ff00b825" borderColor="ff240002" borderStyle="6" iconColor="ff001440" iconStyle="82"/>
      class Emblem
        # @return [String]
        attr_reader :background

        # @return [String]
        attr_reader :border_color

        # @return [Integer]
        attr_reader :border_style

        # @return [String]
        attr_reader :icon_color

        # @return [Integer]
        attr_reader :icon_style

        # @param [Hpricot::Elem] elem <tt>emblem</tt> element
        def initialize(elem)
          @background   = elem[:background]
          @border_color = elem[:borderColor]
          @border_style = elem[:borderStyle].to_i
          @icon_color   = elem[:iconColor]
          @icon_style   = elem[:iconStyle].to_i
        end
      end
    end
  end
end
