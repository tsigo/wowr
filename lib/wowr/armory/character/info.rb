module Wowr
  module Armory
    module Character
      # Character details without reputations
      # uses characterInfo element
      # Made up of two parts, character and charactertab
      class Info < Wowr::Armory::Character::Base

        # character_info
        attr_reader :char_url,
                     :title, :known_titles,
                    :faction, :faction_id,
                    :arena_teams,
                    :last_modified,
                    :points

        # character_tab
        attr_reader :health, :second_bar,
                    :strength, :agility, :stamina, :intellect, :spirit
        alias_method :str, :strength
        alias_method :agi, :agility
        alias_method :sta, :stamina
        alias_method :int, :intellect
        alias_method :spi, :spirit

        attr_reader :melee, :ranged, :spell,
                    :defenses, :resistances,
                    :talent_spec, :all_talent_specs, :pvp,
                    :professions,
                    :items,
                    :buffs, :debuffs

        # It's made up of two parts
        # Don't care about battlegroups yet
        # I don't think I can call stuff from the constructor?
        def initialize(sheet, talents, api = nil)
          super(sheet%'character', api)

          @api = api
          @talents = talents

          character_info(sheet%'character')

          # Check if characterTab is defined. If not, the character have no infos on the armory (not logged since last armory wipe)
          raise Wowr::Exceptions::CharacterNoInfo.new(@name) if (sheet%'characterTab').nil?

          character_tab(sheet%'characterTab')
        end

        # <character
        #  battleGroup="Conviction"
        #  charUrl="r=Genjuros&amp;n=Jonlok"
        #  class="Warlock"
        #  classId="9"
        #  faction="Horde"
        #  factionId="1"
        #  gender="Male"
        #  genderId="0"
        #  guildName=""
        #  lastModified="12 February 2008"
        #  level="41"
        #  name="Jonlok"
        #  prefix=""
        #  points="2270"
        #  race="Orc"
        #  raceId="2"
        #  realm="Genjuros"
        #  suffix=""/>

        def character_info(elem)
          # basic info
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

          @prefix     = elem[:prefix] == "" ? nil : elem[:prefix]
          @suffix     = elem[:suffix] == "" ? nil : elem[:suffix]

          @points     = elem[:points].to_i

          @realm      = elem[:realm]

          @battle_group = elem[:battleGroup]

          # format is February 11, 2008
          # except when it's korean, and then it's 2008년 5월 11일 (일)
          # tw is 2008&#24180;5&#26376;11&#26085; (2008年5月11日)
          # TODO: Datetime doesn't parse other languages nicely
          #       Until then, just save it as a string
          begin
            @last_modified  = elem[:lastModified] == "" ? nil : DateTime.parse(elem[:lastModified])
          rescue
            @last_modified  = elem[:lastModified] == "" ? nil : elem[:lastModified]
          end
          #@last_modified = elem[:lastModified]#.to_time

          @arena_teams = []
          (elem/:arenaTeam).each do |arena_team|
            @arena_teams << Wowr::Classes::ArenaTeam.new(arena_team)
          end

        end

        def character_tab(elem)
          # <title value=""/>
          #@title       = (elem%'title')[:value] == "" ? nil : (elem%'title')[:value]
          if (@prefix || @suffix)
            @title = (@prefix ? @prefix : "") + "%s" + (@suffix ? @suffix : "")
          end

          @known_titles = []

          @known_titles << @title if (@title)

          #@known_titles << @title if (@title)
          #(elem%'knownTitles'/:title).each do |entry|
          #  @known_titles << entry[:value] if (!@known_titles.include?(entry[:value]))
          #end

          @health     = (elem%'characterBars'%'health')[:effective].to_i
          @second_bar = Wowr::Classes::SecondBar.new(elem%'characterBars'%'secondBar')

          # base stats
          @strength   = Wowr::Classes::Strength.new(elem%'baseStats'%'strength')
          @agility    = Wowr::Classes::Agility.new(elem%'baseStats'%'agility')
          @stamina    = Wowr::Classes::Stamina.new(elem%'baseStats'%'stamina')
          @intellect  = Wowr::Classes::Intellect.new(elem%'baseStats'%'intellect')
          @spirit     = Wowr::Classes::Spirit.new(elem%'baseStats'%'spirit')

          # damage stuff
          @melee    = Wowr::Classes::Melee.new(elem%'melee')
          @ranged   = Wowr::Classes::Ranged.new(elem%'ranged')
          @spell    = Wowr::Classes::Spell.new(elem.at(' > spell'))  # TODO: hacky?
          @defenses = Wowr::Classes::Defenses.new(elem%'defenses')

          # TODO: Massive problem, doesn't fill in resistances for some reason
          resist_types = ['arcane', 'fire', 'frost', 'holy', 'nature', 'shadow']
          @resistances = {}
          resist_types.each do |res|
            @resistances[res] = Wowr::Classes::Resistance.new(elem%'resistances'%res)
          end

          @all_talent_specs = []
          (@talents/'//characterInfo/talents/talentGroup').each do |spec|
             new_spec = Wowr::Classes::TalentSpec.new(spec)
             @all_talent_specs << new_spec

             @talent_spec = new_spec if (new_spec.active)
          end

          @pvp = Wowr::Classes::Pvp.new(elem%'pvp')

          @professions = []
          (elem%'professions'/:skill).each do |skill|
            @professions << Wowr::Classes::Skill.new(skill)
          end

          @items = []
          (elem%'items'/:item).each do |item|
            @items << Wowr::Classes::EquippedItem.new(item, @api)
          end

          @buffs = []
          (elem%'buffs'/:spell).each do |buff|
            @buffs << Wowr::Classes::Buff.new(buff, @api)
          end

          @debuffs = []
          (elem%'debuffs'/:spell).each do |debuff|
            @debuffs << Wowr::Classes::Buff.new(debuff, @api)
          end
        end
      end
    end
  end
end
