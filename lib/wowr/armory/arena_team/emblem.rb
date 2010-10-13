module Wowr
  module Armory
    module ArenaTeam
      # An arena team's logo
      class Emblem
        attr_reader :background, :border_color, :border_style, :icon_colour, :icon_style

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
