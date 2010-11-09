module Wowr
  module Armory
    module Achievement
      # = CharacterInfo
      #
      # Represents a summarized <tt>page</tt> element from <tt>character-achievements.xml</tt>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/character-achievements.xml?r=Mal'Ganis&cn=Sebudai&gn=Juggernaut
      class CharacterInfo
        # Five most recently earned achievements
        # @return [Array]
        attr_reader :latest_achievements

        # An array of {CategoryDetails} or {CategoryDetailsWithPoints}
        # attributes, depending on the type of achievement category
        # @return [Array]
        attr_reader :categories

        # @param [Hpricot::Elem] elem <tt>page</tt> element
        def initialize(elem)
          @latest_achievements = Array.new
          @categories          = Array.new

          achievements = elem%'achievements'

          populate_latest_achievements(achievements)
          populate_categories(achievements)
        end

        private

        def populate_latest_achievements(achievements)
          achievements.search('summary/achievement').each do |achievement|
            @latest_achievements << Wowr::Classes::CompletedAchievement.new(achievement)
          end
        end

        def populate_categories(achievements)
          # Completion info is stored in "summary/category/c" without any id attribute,
          # so we're forced to access it by array index. Luckily they're in the same order.
          categories_completion = achievements.search('summary/category/c')

          # TODO: The two AchievementsCategoryDetails classes make this more complicated than it needs to be (tsigo)
          # Just have one class, and it either has the extra completion data, or it doesn't

          # Get the list of rootCategories
          achievements.search('rootCategories/category').each_with_index do |category, i|
            elem = Hash.new
            type = Wowr::Classes::AchievementsCategoryDetails
            elem['id'] = category['id']
            elem['name'] = category['name']
            completion = categories_completion[i]
            elem['earned'] = completion['earned']

            # All categories with the exception of Feats of Strength have a "total" attribute
            if completion['total']
              type = Wowr::Classes::AchievementsCategoryDetailsWithPoints
              elem['total'] = completion['total']
              elem['totalPoints'] = completion['totalPoints']
              elem['earnedPoints'] = completion['earnedPoints']
            end
            new_cat = type.new(elem)

            # Add subcategories
            category.search('category').each do |subcategory|
              subcat = Wowr::Classes::AchievementsCategory.new subcategory
              new_cat.add_subcategory subcat
            end

            @categories << new_cat
          end
        end
      end
    end
  end
end
