module Wowr
  module Armory
    module Achievement
      # = CategoryDetails
      #
      # Represents a <tt>category</tt> element which has a child <tt>c</tt>
      # element with only an <tt>earned</tt> attribute
      #
      # Currently this only occurs with the "Feats of Strength" category.
      #
      # == Relevant XML example:
      #
      #   <category>
      #     <c earned="18"/>
      #   </category>
      class CategoryDetails < Category
        # Number of achievements earned in this category
        # @return [Integer]
        attr_reader :earned

        # @param [Hash] category Category details
        def initialize(category)
          super(category)

          @earned = category[:earned].to_i
        end
      end
    end
  end
end
