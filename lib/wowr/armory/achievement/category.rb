module Wowr
  module Armory
    module Achievement
      # = Category
      #
      # Represents a <tt>category</tt> element
      #
      # == Relevant XML example:
      #
      #   <category id="96" name="Quests">
      class Category
        # @return [String]
        attr_reader :name

        # @return [Array]
        attr_reader :subcategories

        # @return [Integer]
        attr_reader :id

        # @return [Category]
        attr_accessor :parent

        # @param [Nokogiri::XML::Element] elem <tt>category</tt> element
        def initialize(elem)
          @name          = elem[:name]
          @id            = elem[:id].to_i if elem[:id]
          @subcategories = []
        end

        def add_subcategory(category)
          category.parent = self
          @subcategories << category
        end
      end
    end
  end
end
