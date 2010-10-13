module Wowr
  module Armory
    module Guild
      # Basic search information returned by the search.xml
      # <guilds>
      #   <guild
      # battleGroup="Ruin"
      # faction="Alliance"
      # factionId="0"
      # name="HAND"
      # realm="Stormrage"
      # relevance="100"
      # url="r=Stormrage&amp;n=HAND&amp;p=1"/>
      # </guilds>
      class Search < Wowr::Armory::Guild::Base
        attr_reader :faction, :faction_id, :battle_group

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
