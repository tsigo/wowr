module Wowr
  module Armory
    module Character
      # Basic character info
      #
      # This class is used when only partial character information is
      # available, such as in guild lists, or search results.
      #
      # Depending on the type of listing this class represents, some data may
      # be missing. This is a limitation of the information returned by the
      # Armory.
      #
      # @see Wowr::Classes::Guild
      class Base
        # @return [String]
        attr_reader :name

        # @return [Integer]
        attr_reader :level

        # URL parameters for this character
        # @example
        #   r=Mal%27Ganis&cn=Sebudai
        # @return [String]
        attr_reader :url

        # Character class
        # @note <tt>class</tt> is a Ruby reserved keyword, so that can't be used.
        # @example
        #   "Hunter"
        # @return [String]
        attr_reader :klass

        # @return [Integer]
        attr_reader :klass_id

        # @example
        #   "Female"
        # @return [String]
        attr_reader :gender

        # @return [Integer]
        attr_reader :gender_id

        # @example
        #   "Orc"
        # @return [String]
        attr_reader :race

        # @return [Integer]
        attr_reader :race_id

        # Guild name
        # @example
        #   "Juggernaut"
        # @return [String]
        attr_reader :guild

        # @return [Integer]
        attr_reader :guild_id

        # URL parameters for the character's guild page
        # @example
        #   r=Mal%27Ganis&gn=Juggernaut
        # @return [String]
        attr_reader :guild_url

        # @return [String]
        attr_reader :realm

        # @return [String]
        attr_reader :battle_group

        # Search relevance, when representing a search result
        # @return [Integer]
        attr_reader :relevance

        # Search rank, when representing a search result
        # @return [Integer]
        attr_reader :search_rank

        # @return [String]
        attr_reader :last_login

        # @return [Integer]
        attr_reader :achievement_points

        # Games played in total for the current arena season
        # @return [Integer]
        attr_reader :season_games_played

        # Games won for the current arena season
        # @return [Integer]
        attr_reader :season_games_won

        # Arena team rank
        # @return [Integer]
        attr_reader :team_rank

        # Player contribution for the current arena season
        # @return [Integer]
        attr_reader :contribution

        alias_method :to_s, :name
        alias_method :to_i, :level
        alias_method :last_modified, :last_login
        alias_method :wow_class, :klass
        alias_method :class_id, :klass_id

        @@race_icon_url_base = '_images/icons/race/'
        @@class_icon_url_base = '_images/icons/class/'
        @@portrait_url_base = '_images/portraits/'

        @@icon_types = {:default => 'wow-default', 70 => 'wow-70', 80 => 'wow-80', :other => 'wow'}

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

          @battle_group = elem[:battleGroup] == "" ? nil : elem[:battleGroup]

          @relevance    = elem[:relevance].to_i
          @search_rank  = elem[:searchRank].to_i

          @achievement_points = elem[:points].to_i if elem[:points]
          @achievement_points = elem[:achPoints].to_i if elem[:achPoints]

          @last_login = elem[:lastLoginDate] == "" ? nil : elem[:lastLoginDate]

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

          if (type.nil?) && (@level == 80 || @level == 70)
            dir = @@icon_types[@level]
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
          return base + @@race_icon_url_base + "#{@race_id}-#{@gender_id}.gif"
        end

        def class_icon
          # http://armory.worldofwarcraft.com/images/icons/class/8.gif
          return base + @@class_icon_url_base + "#{@klass_id}.gif"
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
