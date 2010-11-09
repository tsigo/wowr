module Wowr
  module Armory
    module Achievement
      # = CategoryDetailsWithPoints
      #
      # Represents a <tt>category</tt> element which has a child <tt>c</tt>
      # element with <tt>earned</tt>, <tt>earnedPoints</tt>, <tt>total</tt> and
      # <tt>totalPoints</tt> attributes
      #
      # == Relevant XML example:
      #
      #   <category>
      #     <c earned="42" earnedPoints="435" total="52" totalPoints="535"/>
      #   </category>
      class CategoryDetailsWithPoints < CategoryDetails
        # Currently earned achievement points in this category
        # @return [Integer]
        attr_reader :earned_points

        # Total achievements in this category
        # @return [Integer]
        attr_reader :total

        # Total achievement points in this category
        # @return [Integer]
        attr_reader :total_points

        # @param [Hash] category Category details
        def initialize(category)
          super(category)

          @earned_points = category[:earnedPoints].to_i
          @total         = category[:total].to_i
          @total_points  = category[:totalPoints].to_i
        end
      end
    end
  end
end
