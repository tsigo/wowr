module Wowr
  module Armory
    module Item
      # = Glyph
      #
      # Represents a <tt>talentGroup/glyphs/glyph</tt> element
      #
      # == Relevant XML example:
      #
      #   <glyph effect="Reduces the focus cost of Trap Launcher by 10." icon="ability_hunter_traplauncher" id="353" name="Glyph of Trap Launcher" type="major"/>
      class Glyph < Base
        # The glyph ID
        # @note This is not the item ID of the glyph
        # @return [Integer]
        attr_reader :id

        # The specified effect of the glyph
        # @return [String]
        attr_reader :effect

        # The type of glyph, either "Minor", "Major", or "Prime"
        # @return [String]
        attr_reader :type

        # @param [Nokogiri::XML::Element] elem <tt>glyph</tt> element
        def initialize(elem)
          @id        = elem[:id].to_i
          @name      = elem[:name]
          @icon_base = elem[:icon]
          @effect    = elem[:effect]
          @type      = elem[:type]
        end
      end
    end
  end
end
