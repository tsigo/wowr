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
          achievements.search('rootCategories/category').each_with_index do |elem, i|
            details = {}

            type = Wowr::Classes::AchievementsCategoryDetails
            completion = categories_completion[i]

            details[:id]     = elem[:id]
            details[:name]   = elem[:name]
            details[:earned] = completion[:earned]

            # All categories with the exception of Feats of Strength have a "total" attribute
            if completion[:total]
              type = Wowr::Classes::AchievementsCategoryDetailsWithPoints

              details[:total]        = completion[:total]
              details[:totalPoints]  = completion[:totalPoints]
              details[:earnedPoints] = completion[:earnedPoints]
            end

            category = type.new(details)

            # Add subcategories
            elem.search('category').each do |sub_elem|
              category.add_subcategory(Wowr::Classes::AchievementsCategory.new(sub_elem))
            end

            @categories << category
          end
        end
      end
    end
  end
end
