module Wowr
  module Armory
    module ArenaTeam
      # = SearchResult
      #
      # Represents an <tt>arenaTeam</tt> element from a search result
      #
      # == Relevant XML example:
      #
      #   <arenaTeam battleGroup="Cyclone" created="1231545600000"
      #     faction="Horde" factionId="1" gamesPlayed="0" gamesWon="0"
      #     lastSeasonRanking="0" name="LEMON" ranking="0" rating="0"
      #     realm="Stormscale" realmUrl="b=Cyclone&amp;r=Stormscale&amp;ts=2&amp;t=LEMON&amp;ff=realm&amp;fv=Stormscale&amp;select=LEMON"
      #     relevance="100" season="0" seasonGamesPlayed="0" seasonGamesWon="0"
      #     size="2" teamSize="2" teamUrl="r=Stormscale&amp;ts=2&amp;t=LEMON&amp;select=LEMON"
      #     url="r=Stormscale&amp;ts=2&amp;t=LEMON&amp;select=LEMON">
      class SearchResult < Base
        # Search relevance
        # @return [Integer]
        attr_reader :relevance

        # @param [Hpricot::Elem] elem <tt>arenaTeam</tt> element
        def initialize(elem)
          super(elem)

          @relevance = elem[:relevance].to_i
        end
      end
    end
  end
end
