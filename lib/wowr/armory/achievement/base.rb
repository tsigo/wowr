module Wowr
  module Armory
    module Achievement
      class Base
        attr_reader :desc, :title, :category_id, :icon, :id, :points, :reward
        def initialize achievement
          @desc = achievement['desc']
          @category_id = achievement['categoryId'].to_i
          @icon = achievement['icon']
          @id = achievement['id'].to_i

          if achievement['points']
            @points = achievement['points'].to_i
          else
            @points = nil
          end

          if achievement['reward']
            @reward = achievement['reward']
          else
            @reward = nil
          end

          @title = achievement['title']
        end
      end
    end
  end
end
