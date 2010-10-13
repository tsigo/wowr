module Wowr
  module Armory
    module Character
      # Short character info, used in guild lists etc.
      # Note that the way that searches and character listings within guilds works,
      # there can be a variable amount of information filled in within the class.
      # Guild listings and search results contain a smaller amount of information than
      # single queries
      # Attributes
      # * name (String) - Full character name
      # * level (Fixnum) - Level
      # See Also: Guild
      class Base
        # TODO: remove non existant attr_readers? :rank, :relevance
        attr_reader :name, :level, :url, :rank,
                    :klass, :klass_id,
                    :gender, :gender_id,
                    :race, :race_id,
                    :guild, :guild_id, :guild_url,
                    :realm,
                    :battle_group, :last_login,
                    :relevance, :search_rank,
                    :achievement_points,

                    :season_games_played, :season_games_won, :team_rank, :contribution # From ArenaTeam info

        alias_method :to_s, :name
        alias_method :to_i, :level

        @@race_icon_url_base = '_images/icons/race/'
        @@class_icon_url_base = '_images/icons/class/'
        @@portrait_url_base = '_images/portraits/'

        @@icon_types = {:default => 'wow-default', 70 => 'wow-70', :other => 'wow'}

        def initialize(elem, api = nil)
          @api = api

          @name       = elem[:name]
          @level      = elem[:level].to_i
          @url        = elem[:url] || elem[:charUrl]

          @rank       = elem[:rank].to_i # TODO: remove? this doesn't seem to exist anymore in xml

          @klass      = elem[:class]
          @klass_id   = elem[:classId].to_i

          @gender     = elem[:gender]
          @gender_id  = elem[:genderId].to_i

          @race       = elem[:race]
          @race_id    = elem[:raceId].to_i

          @guild      = elem[:guild] == "" ? nil : elem[:guild]
          @guild_id   = elem[:guildId].to_i == 0 ? nil : elem[:guildId].to_i
          @guild_url  = elem[:guildUrl] == "" ? nil : elem[:guildUrl]

          @realm      = elem[:realm] == "" ? nil : elem[:realm]

          @battle_group     = elem[:battleGroup] == "" ? nil : elem[:battleGroup]

          @battle_group_id  = elem[:battleGroupId].to_i # TODO :remove? this doesn't seem to be used

          @relevance    = elem[:relevance].to_i # TODO: remove? this doesn't seem to exist anymore in xml
          @search_rank  = elem[:searchRank].to_i # TODO: remove? this doesn't seem to exist anymore in xml

          @achievement_points = elem[:points].to_i if elem[:points]
          @achievement_points = elem[:achPoints].to_i if elem[:achPoints]

          # Incoming string is 2007-02-24 20:33:04.0, parse to datetime
          #@last_login  = elem[:lastLoginDate] == "" ? nil : DateTime.parse(elem[:lastLoginDate])

          @last_login   = elem[:lastLoginDate] == "" ? nil : elem[:lastLoginDate] # TODO: remove? this doesn't seem to exist anymore in xml

          # From ArenaTeam info, can be blank on normal requests
          #<character battleGroup="" charUrl="r=Draenor&amp;n=Lothaar" class="Paladin" classId="2"
          # contribution="1602" gamesPlayed="10" gamesWon="7" gender="Male" genderId="0"
          # guild="Passion" guildId="36659" guildUrl="r=Draenor&amp;n=Passion&amp;p=1" name="Lothaar"
          # race="Human" raceId="1" seasonGamesPlayed="20" seasonGamesWon="13" teamRank="1"/>
          @season_games_played  = elem[:seasonGamesPlayed] == "" ? nil : elem[:seasonGamesPlayed].to_i
          @season_games_won     = elem[:seasonGamesWon] == "" ? nil : elem[:seasonGamesWon].to_i
          @team_rank            = elem[:teamRank] == "" ? nil : elem[:teamRank].to_i
          @contribution         = elem[:contribution] == "" ? nil : elem[:contribution].to_i
        end

        def icon(type = nil)
          if !type.nil? && !@@icon_types.include?(type)
            raise Wowr::Exceptions::InvalidIconType.new(@@icon_types)
          end

          if (type.nil?) && (@level == 70)
            dir = @@icon_types[70]
          elsif (type.nil?)
            dir = @@icon_types[:other]
          else
            dir = @@icon_types[type]
          end

          # http://armory.worldofwarcraft.com/images/portraits/wow-70/1-7-8.gif
          return base + @@portrait_url_base + dir + "/#{@gender_id}-#{@race_id}-#{@klass_id}.gif"
        end


        def race_icon
          # http://armory.worldofwarcraft.com/images/icons/race/11-1.gif
          return base + @@race_icon_url_base + "#{@race_id}-#{@gender_id.to_s}.gif"
        end


        def class_icon
          # http://armory.worldofwarcraft.com/images/icons/class/8.gif
          return base + @@class_icon_url_base + "#{@klass_id.to_s}.gif"
        end

        protected

        def base
          if @api
            return @api.base_url
          else
            return 'http://www.wowarmory.com/'
          end
        end
      end
    end
  end
end
