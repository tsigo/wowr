module Wowr
  module Armory
    module Achievement
      # = List
      #
      # Represents a full <tt>achievements</tt> element
      #
      # == Relevant XML example:
      #
      #   <achievements lang="en_us" requestUrl="/character-achievements.xml">
      #     <category>
      #       <achievement categoryId="81" dateCompleted="2010-03-23T18:42:00-05:00" desc="Earn any variety of Emblem." icon="inv_misc_frostemblem_01" id="4785" title="Emblematic"/>
      #       <achievement categoryId="81" dateCompleted="2010-03-15T21:07:00-05:00" desc="In the Trial of the Grand Crusader, reach a Tribute Chest with 50 attempts remaining and without allowing any raid member to die during any of the boss encounters in 25-player mode." icon="achievement_reputation_argentchampion" id="4079" reward="Reward: Crusader's Black Warhorse" title="A Tribute to Immortality">
      #         <criteria id="12358" name="Complete the Trial of the Grand Crusader"/>
      #       </achievement>
      #       <achievement categoryId="81" dateCompleted="2009-09-23T22:14:00-05:00" desc="Participated in the realm first conquest of the Trial of the Grand Crusader with 50 attempts remaining in 25-player mode." icon="achievement_reputation_argentcrusader" id="4078" reward="Title Reward: The Grand Crusader" title="Realm First! Grand Crusader">
      #         <criteria id="12350" name="Complete the Trial of the Grand Crusader"/>
      #       </achievement>
      #     </category>
      #   </achievements>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/character-achievements.xml?r=Mal'Ganis&cn=Sebudai&gn=Juggernaut&c=81
      # * http://www.wowarmory.com/character-achievements.xml?r=Mal'Ganis&cn=Sebudai&gn=Juggernaut&c=168
      class List
        # @return [Array]
        attr_reader :achievements

        # @param [Nokogiri::XML::Element] elem <tt>achievements</tt> element
        def initialize(elem)
          @achievements = Array.new
          elem.search('achievement').each do |achievement|
            if achievement['dateCompleted']
              @achievements << Wowr::Classes::CompletedAchievement.new(achievement)
            else
              @achievements << Wowr::Classes::Achievement.new(achievement)
            end
          end
        end
      end
    end
  end
end
