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

        # @return [Hash]
        attr_reader :bosses

        alias_method :to_s, :name
        alias_method :to_i, :id
        alias_method :max_level, :level_maximum
        alias_method :min_level, :level_minimum

        # @param [Nokogiri::XML::Element] elem <tt>dungeon</tt> element
        def initialize(elem)
          @id             = elem[:id].to_i
          @key            = elem[:key]
          @level_minimum  = elem[:levelMin].to_i
          @level_maximum  = elem[:levelMax].to_i
          @party_size     = elem[:partySize].to_i
          @raid           = (elem[:raid].to_i == 1) ? true : false
          @release        = elem[:release].to_i
          @heroic         = (elem[:hasHeroic].to_i == 1) ? true : false

          # Ideally want to be able to get the boss by both ID and key
          # but by using normal hash.
          # After a test it seems the method below creates 2 references to an object.
          @bosses = {}

          (elem/:boss).each do |elem|
            # TODO: Is this insane?
            #       After object test, appears this will be references to the same object
            boss = Wowr::Classes::Boss.new(elem)
            # FIXME: do we really need to have 'boss' for both 'id' and 'key' in the dungeon's bosses hash?
            @bosses[boss.id]  = boss
            @bosses[boss.key] = boss
          end
        end

        # Add the name data from dungeonStrings.xml
        def add_name_data(elem)
          @name = elem.attributes["name"]

          (elem/:boss).each do |boss_elem|
            id = boss_elem[:id].to_i
            key = boss_elem[:key]

            @bosses[id].add_name_data(boss_elem)
            @bosses[key].add_name_data(boss_elem)
          end
        end
      end
    end
  end
end
