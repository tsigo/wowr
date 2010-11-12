module Wowr
  module Armory
    module Item
      # = SetBonus
      #
      # Represents a <tt>setData/setBonus</tt> element
      #
      # == Relevant XML examples:
      #
      #   <setBonus desc="Increases the damage done by your Devouring Plague by 15%." threshold="2"/>
      #
      #   <setBonus desc="Your Mind Blast also grants you 240 haste rating for 4 sec." threshold="4"/>
      class SetBonus
        # Number of pieces required to activate this bonus
        # @return [Integer]
        attr_reader :threshold

        # @return [String]
        attr_reader :description

        alias_method :desc, :description
        alias_method :to_s, :description

        # @param [Nokogiri::XML::Element] elem <tt>setBonus</tt> element
        def initialize(elem)
          @threshold   = elem[:threshold].to_i
          @description = elem[:desc]
        end
      end
    end
  end
end
