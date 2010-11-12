module Wowr
  module Armory
    module ArenaTeam
      # = Full
      #
      # Represents an <tt>arenaTeam</tt> element from a character-sheet or team-info page
      #
      # == Relevant XML example:
      #
      #    <arenaTeam battleGroup="Stormstrike" created="1254009600000" faction="Alliance" factionId="0" gamesPlayed="0" gamesWon="0" lastSeasonRanking="1" name="Dont Kill Comfort" ranking="0" rating="0" realm="Ysera" realmUrl="b=Stormstrike&amp;r=Ysera&amp;ts=5&amp;t=Dont+Kill+Comfort&amp;ff=realm&amp;fv=Ysera&amp;select=Dont+Kill+Comfort" relevance="0" season="0" seasonGamesPlayed="0" seasonGamesWon="0" size="5" teamSize="5" teamUrl="r=Ysera&amp;ts=5&amp;t=Dont+Kill+Comfort&amp;select=Dont+Kill+Comfort" teamUrlEscape="r=Ysera&amp;ts=5&amp;t=Dont+Kill+Comfort&amp;select=Dont+Kill+Comfort" url="r=Ysera&amp;ts=5&amp;t=Dont+Kill+Comfort&amp;select=Dont+Kill+Comfort">
      #      <emblem background="ff00b825" borderColor="ff240002" borderStyle="6" iconColor="ff001440" iconStyle="82"/>
      #      <members>
      #        <character battleGroup="Stormstrike" charUrl="r=Ysera&amp;cn=Magnifibeast" class="Hunter" classId="3" contribution="0" gamesPlayed="0" gamesWon="0" gender="Male" genderId="0" guild="Midwinter" guildId="41835" guildUrl="r=Ysera&amp;gn=Midwinter" name="Magnifibeast" race="Dwarf" raceId="3" realm="Ysera" seasonGamesPlayed="0" seasonGamesWon="0" teamRank="0"/>
      #        <character battleGroup="Stormstrike" charUrl="r=Ysera&amp;cn=Purplemonger" class="Paladin" classId="2" contribution="0" gamesPlayed="0" gamesWon="0" gender="Female" genderId="1" guild="Midwinter" guildId="41835" guildUrl="r=Ysera&amp;gn=Midwinter" name="Purplemonger" race="Human" raceId="1" realm="Ysera" seasonGamesPlayed="0" seasonGamesWon="0" teamRank="1"/>
      #        <character battleGroup="Stormstrike" charUrl="r=Ysera&amp;cn=Magnilol" class="Mage" classId="8" contribution="0" gamesPlayed="0" gamesWon="0" gender="Female" genderId="1" guild="Midwinter" guildId="41835" guildUrl="r=Ysera&amp;gn=Midwinter" name="Magnilol" race="Human" raceId="1" realm="Ysera" seasonGamesPlayed="0" seasonGamesWon="0" teamRank="1"/>
      #        <character battleGroup="Stormstrike" charUrl="r=Ysera&amp;cn=Kras" class="Priest" classId="5" contribution="0" gamesPlayed="0" gamesWon="0" gender="Male" genderId="0" guild="Midwinter" guildId="41835" guildUrl="r=Ysera&amp;gn=Midwinter" name="Kras" race="Human" raceId="1" realm="Ysera" seasonGamesPlayed="0" seasonGamesWon="0" teamRank="1"/>
      #        <character battleGroup="Stormstrike" charUrl="r=Ysera&amp;cn=Dpsonroids" class="Warlock" classId="9" contribution="0" gamesPlayed="0" gamesWon="0" gender="Male" genderId="0" guild="Midwinter" guildId="41835" guildUrl="r=Ysera&amp;gn=Midwinter" name="Dpsonroids" race="Human" raceId="1" realm="Ysera" seasonGamesPlayed="0" seasonGamesWon="0" teamRank="1"/>
      #        <character battleGroup="Stormstrike" charUrl="r=Ysera&amp;cn=Revai" class="Shaman" classId="7" contribution="0" gamesPlayed="0" gamesWon="0" gender="Female" genderId="1" guild="Midwinter" guildId="41835" guildUrl="r=Ysera&amp;gn=Midwinter" name="Revai" race="Draenei" raceId="11" realm="Ysera" seasonGamesPlayed="0" seasonGamesWon="0" teamRank="1"/>
      #      </members>
      #    </arenaTeam>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/character-sheet.xml?cn=Sebudai&r=Mal'Ganis
      # * http://www.wowarmory.com/team-info.xml?r=Mal'Ganis&ts=5&t=E+P+I+X&select=E+P+I+X
      # * http://www.wowarmory.com/team-info.xml?r=Mal'Ganis&ts=3&t=our+DK+is+an+ALT&select=our+DK+is+an+ALT
      class Full < Base
        # Array of team members
        # @return [Hash]
        attr_reader :members

        # @param [Nokogiri::XML::Element] elem <tt>arenaTeam</tt> element
        def initialize(elem)
          super(elem)

          @members = {}
          (elem%'members'/'character').each do |character|
            @members[character[:name]] = Wowr::Armory::Character::Base.new(character)
          end
        end
      end
    end
  end
end
