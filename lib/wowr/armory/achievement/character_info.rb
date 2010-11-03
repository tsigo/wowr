module Wowr
  module Armory
    module Achievement
      class CharacterInfo
        attr_reader :latest_achievements, :categories

        def initialize elem, api
          @api = api
          @latest_achievements = Array.new
          @categories = Array.new

          achievements = elem%'achievements'
          summary = achievements%'summary'

          # Get list of latest achievements
          summary.search('achievement').each do |achievement|
            @latest_achievements << Wowr::Classes::CompletedAchievement.new(achievement)
          end

          # Get the infos about categories completion
          # They are ordered in same order as categories below
          categories_completion = summary.search('category/c')

          # Get the list of rootCategories
          i = 0
          achievements.search('rootCategories/category').each do |category|
            elem = Hash.new
            type = Wowr::Classes::AchievementsCategoryDetails
            elem['id'] = category['id']
            elem['name'] = category['name']
            completion = categories_completion[i]
            elem['earned'] = completion['earned']

            # If we have more informations
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
            i = i+1
          end
        end
      end
    end
  end
end
