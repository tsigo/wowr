module Wowr
  module Armory
    module Character
      # = Info
      #
      # Represents basic information about a character, along with their talent
      # information from the <tt>character-sheet.xml</tt> and
      # <tt>character-talents.xml</tt> pages
      class Info < Base
        # Character URL parameters
        # @example
        #   "r=Mal%27Ganis&amp;cn=Sebudai"
        # @return [String]
        attr_reader :char_url

        # A formatted string containing either the character's prefix or suffix
        # @example
        #   "Grand Crusader %s"
        #   "%s the Light of Dawn"
        #   "%s Jenkins"
        # @return [String]
        attr_reader :title

        # @return [String]
        attr_reader :faction

        # @see Wowr::Armory#faction
        # @return [Integer]
        attr_reader :faction_id

        # @return [Array] Array of Wowr::ArenaTeam::Base instances
        attr_reader :arena_teams

        # @return [DateTime, String]
        attr_reader :last_modified

        # Achievement points
        # @return [Integer]
        attr_reader :points

        # @return [Integer]
        attr_reader :health

        # @return [SecondBar]
        attr_reader :second_bar

        # @return [BaseStats::Agility]
        attr_reader :agility

        # @return [BaseStats::Intellect]
        attr_reader :intellect

        # @return [BaseStats::Spirit]
        attr_reader :spirit

        # @return [BaseStats::Stamina]
        attr_reader :stamina

        # @return [BaseStats::Strength]
        attr_reader :strength

        # Melee stats
        # @return [Melee]
        attr_reader :melee

        # Ranged stats
        # @return [Ranged]
        attr_reader :ranged

        # Spell stats
        # @return [Spell]
        attr_reader :spell

        # Defense stats
        # @return [Defenses]
        attr_reader :defenses

        # @return [Array] Array of {Resistance} instances
        attr_reader :resistances

        # Currently active talent spec
        # @return [TalentSpec]
        attr_reader :talent_spec

        # @return [Array] Array of {TalentSpec} instances
        attr_reader :all_talent_specs

        # PVP statistics
        # @return [Pvp]
        attr_reader :pvp

        # @return [Array] Array of {Skill} instances
        attr_reader :professions

        # @return [Array] Array of {Skill} instances
        attr_reader :secondary_professions

        # @return [Array] Array of {EquippedItem} instances
        attr_reader :items

        alias_method :agi, :agility
        alias_method :int, :intellect
        alias_method :spi, :spirit
        alias_method :sta, :stamina
        alias_method :str, :strength

        # @param [Hpricot::Elem] sheet <tt>character-sheet.xml</tt> page
        # @param [Hpricot::Elem] talents <tt>character-talents.xml</tt> page
        # @param [Wowr::API::API] api
        def initialize(sheet, talents, api = nil)
          super(sheet%'character', api)

          @api = api
          @talent_elem = talents

          character_info(sheet%'character')

          # Check if characterTab is defined. If not, the character have no infos on the armory (not logged since last armory wipe)
          raise Wowr::Exceptions::CharacterNoInfo.new(@name) if (sheet%'characterTab').nil?

          character_tab(sheet%'characterTab')
        end

        # @deprecated
        def known_titles
          puts "** [DEPRECATED] 'known_titles' is deprecated, as the data has been removed from the Armory"
          [@title]
        end

        private

        # Populate what we can from the basic <tt>character</tt> element
        #
        # == Relevant XML example:
        #
        #   <character battleGroup="Stormstrike"
        #     charUrl="r=Mal%27Ganis&amp;cn=Sebudai" class="Hunter" classId="3"
        #     classUrl="c=Hunter" faction="Horde" factionId="1" gender="Male"
        #     genderId="0" guildName="Juggernaut"
        #     guildUrl="r=Mal%27Ganis&amp;gn=Juggernaut" lastModified="November
        #     9, 2010" level="80" name="Sebudai" points="9180" prefix=""
        #     race="Orc" raceId="2" realm="Mal'Ganis" suffix=" the Light of Dawn"
        #     titleId="138">
        #
        # @param [Hpricot::Elem] elem <tt>character</tt> element
        def character_info(elem)
          @name       = elem[:name]
          @level      = elem[:level].to_i
          @char_url   = elem[:charUrl]

          @klass      = elem[:class]
          @klass_id   = elem[:classId].to_i

          @gender     = elem[:gender]
          @gender_id  = elem[:genderId].to_i

          @race       = elem[:race]
          @race_id    = elem[:raceId].to_i

          @faction    = elem[:faction]
          @faction_id = elem[:factionId].to_i

          @guild      = elem[:guildName] == "" ? nil : elem[:guildName]
          @guild_url  = elem[:guildUrl] == "" ? nil : elem[:guildUrl]

          if elem[:prefix] || elem[:suffix]
            @title = elem[:prefix].to_s + "%s" + elem[:suffix].to_s
          end

          @points = elem[:points].to_i

          @realm = elem[:realm]
          @battle_group = elem[:battleGroup]

          # format is February 11, 2008
          # except when it's korean, and then it's 2008년 5월 11일 (일)
          # tw is 2008&#24180;5&#26376;11&#26085; (2008年5月11日)
          # TODO: Datetime doesn't parse other languages nicely
          #       Until then, just save it as a string
          begin
            @last_modified = DateTime.parse(elem[:lastModified].to_s)
          rescue ArgumentError
            @last_modified = elem[:lastModified].to_s
          end

          @arena_teams = []
          (elem/:arenaTeam).each do |arena_team|
            @arena_teams << Wowr::Armory::ArenaTeam::Base.new(arena_team)
          end

        end

        # Populate remaining attributes from the <tt>characterTab</tt> element
        #
        # @param [Hpricot::Elem] elem <tt>characterTab</tt> element
        def character_tab(elem)
          @health     = (elem%'characterBars'%'health')[:effective].to_i
          @second_bar = SecondBar.new(elem%'characterBars'%'secondBar')

          @agility    = BaseStats::Agility.new(elem%'baseStats'%'agility')
          @intellect  = BaseStats::Intellect.new(elem%'baseStats'%'intellect')
          @spirit     = BaseStats::Spirit.new(elem%'baseStats'%'spirit')
          @stamina    = BaseStats::Stamina.new(elem%'baseStats'%'stamina')
          @strength   = BaseStats::Strength.new(elem%'baseStats'%'strength')

          @defenses = Defenses.new(elem%'defenses')
          @melee    = Melee.new(elem%'melee')
          @ranged   = Ranged.new(elem%'ranged')
          @spell    = Spell.new(elem%'spell')

          @resistances = {}
          Wowr::Armory::ELEMENT_TYPES.each do |type|
            @resistances[type.to_s] = Resistance.new(elem%'resistances'%type)
          end

          @all_talent_specs = []
          @talent_elem.search('talents/talentGroup').each do |group|
             spec = TalentSpec.new(group)
             @all_talent_specs << spec

             @talent_spec = spec if spec.active
          end

          @pvp = Pvp.new(elem%'pvp')

          @professions = []
          (elem%'professions'/:skill).each do |skill|
            @professions << Skill.new(skill)
          end

          @secondary_professions = []
          (elem%'secondaryProfessions'/:skill).each do |skill|
            @secondary_professions << Skill.new(skill)
          end

          @items = []
          (elem%'items'/:item).each do |item|
            @items << EquippedItem.new(item, @api)
          end
        end
      end
    end
  end
end
