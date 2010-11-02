module Wowr
  module Armory
    module Achievement
      class List
        attr_reader :achievements
        def initialize elem, api
          @api = api
          @achievements = Array.new
          elem.search('achievement').each do |achievement|
            if achievement['dateCompleted']
              new_achievement = Wowr::Classes::CompletedAchievement.new(achievement)
            else
              new_achievement = Wowr::Classes::Achievement.new(achievement)
            end
            @achievements << new_achievement

          end
        end
      end
    end
  end
end
