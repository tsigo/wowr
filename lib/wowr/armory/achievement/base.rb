module Wowr
  module Armory
    module Achievement
      # = Base
      #
      # Represents an <tt>achievment</tt> element
      #
      # == Relevant XML example:
      #
      #   <achievement categoryId="168" dateCompleted="2010-05-25T21:03:00-05:00"
      #     desc="Complete the 25-player raid achievements listed below." icon="inv_helmet_151"
      #     id="4603" points="25" reward="Reward: Icebound Frostbrood Vanquisher"
      #     title="Glory of the Icecrown Raider (25 player)"/>
      class Base
        # @return [String]
        attr_reader :desc

        # @return [String]
        attr_reader :title

        # @return [Integer]
        attr_reader :category_id

        # @return [String]
        attr_reader :icon

        # @return [Integer]
        attr_reader :id

        # @return [Integer]
        attr_reader :points

        # @example
        #   "Reward: Icebound Frostbrood Vanquisher"
        # @return [String]
        attr_reader :reward

        # @param [Nokogiri::XML::Element] achievement <tt>achievement</tt> element
        def initialize(achievement)
          @desc        = achievement[:desc]
          @category_id = achievement[:categoryId].to_i
          @icon        = achievement[:icon]
          @id          = achievement[:id].to_i
          @points      = achievement[:points].to_i
          @reward      = achievement[:reward]
          @title       = achievement[:title]
        end
      end
    end
  end
end
