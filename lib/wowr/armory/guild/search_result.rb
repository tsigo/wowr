module Wowr
  module Armory
    module Guild
      # Represents a single <tt><guild></tt> element returned by a guild search
      #
      # == Relevant XML example:
      #
      #   <guild battleGroup="Stormstrike" emblemBackground="4" emblemBorderColor="15"
      #     emblemBorderStyle="1" emblemIconColor="15" emblemIconStyle="84" faction="Horde"
      #     factionId="1" name="Juggernaut" realm="Mal'Ganis" relevance="100" 
      #     url="r=Mal%27Ganis&amp;gn=Juggernaut"/>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/search.xml?searchQuery=Juggernaut&searchType=guilds
      #
      # @see Base
      class SearchResult < Wowr::Armory::Guild::Base
        # @example
        #   "Alliance"
        #   "Horde"
        # @return [String]
        attr_reader :faction

        # Faction ID:
        # * 0 - Alliance
        # * 1 - Horde
        # @return [Integer]
        attr_reader :faction_id

        # @return [String]
        attr_reader :battle_group

        # Search relevance
        # @return [Integer]
        attr_reader :relevance

        # @param [Hpricot::Elem] elem <tt><guild></tt> element
        def initialize(elem)
          super(elem)

          @battle_group = elem[:battleGroup]
          @faction      = elem[:faction]
          @faction_id   = elem[:factionId].to_i

          @relevance    = elem[:relevance].to_i
        end
      end
    end
  end
end
