module Wowr
  module Armory
    module Achievement
      class CategoryDetailsWithPoints < CategoryDetails
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
