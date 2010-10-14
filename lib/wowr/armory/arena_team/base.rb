module Wowr
  module Armory
    module ArenaTeam
      class Base
        attr_reader :name, :size, :battle_group, :faction, :faction_id, :realm, :realm_url,
          :games_played, :games_won, :ranking, :rating,
          :season_games_played, :season_games_won, :last_season_ranking,
          :relevance, :url, :url_escape,
          :characters,  # can be blank on search results
          :emblem
        alias_method :to_s, :name

        def initialize(elem)
          @name         = elem[:name]
          @size         = elem[:size].to_i
          @battle_group = elem[:battleGroup]
          @faction      = elem[:faction]
          @faction_id   = elem[:factionId].to_i
          @realm        = elem[:realm]
          @realm_url    = elem[:realmUrl]

          @games_played = elem[:gamesPlayed].to_i
          @games_won    = elem[:gamesWon].to_i
          # @ranking      = elem[:ranking].to_i # Ranking in the seach results is always 0
          @rating       = elem[:rating].to_i

          @season_games_played  = elem[:seasonGamesPlayed].to_i
          @season_games_won     = elem[:seasonGamesWon].to_i
          @last_season_ranking  = elem[:lastSeasonRanking].to_i

          @relevance    = elem[:relevance].to_i
          @url          = elem[:url]

          @emblem       = Wowr::Classes::ArenaTeamEmblem.new(elem%'emblem')
        end
      end
    end
  end
end
