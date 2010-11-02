module Wowr
  module Armory
    module Achievement
      class Category
        attr_reader :name
        attr_reader :subcategories
        attr_reader :id
        attr_writer :parent
        def initialize category
          @name = category['name']
          @id = category['id'].to_i if category['id']
          @subcategories = Array.new
        end

        def add_subcategory category
          @subcategories << category
          category.parent = self
        end
      end
      
      class CategoryDetail < Category
        attr_reader :earned
        def initialize category
          super(category)
          @earned = category['earned'].to_i
        end
      end
      
      class CategoryDetailWithPoints < CategoryDetail
        attr_reader :earned_points, :total, :total_points
        def initialize category
          super(category)
          @earned_points = category['earnedPoints'].to_i
          @total = category['total'].to_i
          @total_points = category['totalPoints'].to_i
        end
      end
    end
  end
end
