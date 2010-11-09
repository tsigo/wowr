module Wowr
  module Armory
    module Achievement
      class CategoryDetails < Category
        attr_reader :earned
        def initialize category
          super(category)
          @earned = category['earned'].to_i
        end
      end
    end
  end
end
