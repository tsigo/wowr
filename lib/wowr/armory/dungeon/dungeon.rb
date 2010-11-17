# TODO: This class requires some thought as its source is different to others
#       The data source for other classes are single XML files that contain
#       information relevant to the request.
#       Dungeon data is stored in two large (7kb each) files.
#       Even with caching this is going to be slow as the entire XML file has
#       to be read in and built even for a single look-up.
module Wowr
  module Armory
    module Dungeon
      # = Dungeon
      #
      # Represents a <tt>dungeon</tt> element
      #
      # == Relevant XML example:
      #
      #   <dungeon hasHeroic="1" id="2159" key="onyxiaslair" levelMax="80" levelMin="80" nameId="2159" partySize="25" raid="1" release="2">
      #       <bosses>
      #       <boss id="10184" key="onyxia" type="npc">
      #           <lootTable difficulty="n" id="10184" type="npc"/>
      #           <lootTable difficulty="h" id="36538" type="npc"/>
      #       </boss>
      #       </bosses>
      #   </dungeon>
      class Dungeon
        # @return [Integer]
        attr_reader :id

        # @example
        #   "onyxiaslair"
        # @return [String]
        attr_reader :key

        # @example
        #   "Onyxia's Lair"
        # @return [String]
        attr_reader :name

        # @return [Integer]
        attr_reader :level_minimum

        # @return [Integer]
        attr_reader :level_maximum

        # @return [Integer]
        attr_reader :party_size

        # @return [Boolean]
        attr_reader :raid

        # @return [Integer]
        attr_reader :release

        # @return [Boolean]
        attr_reader :heroic

        # @return [Bosses]
        attr_reader :bosses

        alias_method :to_s, :name
        alias_method :to_i, :id
        alias_method :max_level, :level_maximum
        alias_method :min_level, :level_minimum

        # @param [Nokogiri::XML::Element] elem <tt>dungeon</tt> element from <tt>dungeons.xml</tt>
        # @param [Nokogiri::XML::Element] name_data_elem <tt>dungeon</tt> element from <tt>dungeonStrings.xml</tt>
        def initialize(elem, name_data_elem)
          @id             = elem[:id].to_i
          @key            = elem[:key]
          @name           = name_data_elem[:name]
          @level_minimum  = elem[:levelMin].to_i
          @level_maximum  = elem[:levelMax].to_i
          @party_size     = elem[:partySize].to_i
          @raid           = elem[:raid].to_i == 1 ? true : false
          @release        = elem[:release].to_i
          @heroic         = elem[:hasHeroic].to_i == 1 ? true : false

          @bosses = Bosses.new
          (elem/:boss).each do |elem|
            boss = Boss.new(elem)

            name_id = boss.name_id ? boss.name_id : boss.id
            boss.name = name_data_elem.search("boss[@id='#{name_id}']").first[:name]

            @bosses[boss.id, boss.key] = boss
          end
        end
      end
    end
  end
end
