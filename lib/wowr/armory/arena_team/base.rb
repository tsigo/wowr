module Wowr
  module Armory
    module ArenaTeam
      # = Base
      #
      # Represents an <tt>areanTeam</tt> element from multiple sources
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
      class Base
        # @return [String]
        attr_reader :name

        # @return [Integer]
        attr_reader :size

        # @return [String]
        attr_reader :battle_group

        # @return [String]
        attr_reader :faction

        # Faction ID:
        # * 0 - Alliance
        # * 1 - Horde
        # @return [Integer]
        attr_reader :faction_id

        # @return [String]
        attr_reader :realm

        # @return [String]
        attr_reader :realm_url

        # @return [Integer]
        attr_reader :games_played

        # @return [Integer]
        attr_reader :games_won

        # @return [Integer]
        attr_reader :ranking

        # @return [Integer]
        attr_reader :rating

        # @return [Integer]
        attr_reader :season_games_played

        # @return [Integer]
        attr_reader :season_games_won

        # @return [Integer]
        attr_reader :last_season_ranking

        # @return [String]
        attr_reader :url

        # @return [Emblem]
        attr_reader :emblem

        alias_method :to_s, :name

        # @param [Nokogiri::XML::Element] elem <tt>arenaTeam</tt> element
        def initialize(elem)
          @name                = elem[:name]
          @size                = elem[:size].to_i
          @battle_group        = elem[:battleGroup]
          @faction             = elem[:faction]
          @faction_id          = elem[:factionId].to_i
          @realm               = elem[:realm]
          @realm_url           = elem[:realmUrl]

          @games_played        = elem[:gamesPlayed].to_i
          @games_won           = elem[:gamesWon].to_i
          @rating              = elem[:rating].to_i

          @season_games_played = elem[:seasonGamesPlayed].to_i
          @season_games_won    = elem[:seasonGamesWon].to_i
          @last_season_ranking = elem[:lastSeasonRanking].to_i

          @url                 = elem[:url]

          @emblem              = Wowr::Classes::ArenaTeamEmblem.new(elem%'emblem')
        end
      end
    end
  end
end
