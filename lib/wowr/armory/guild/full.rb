module Wowr
  module Armory
    module Guild
      # Full guild data
      # <guildKey factionId="0" name="HAND" nameUrl="HAND" realm="Stormrage" realmUrl="Stormrage" url="r=Stormrage&amp;n=HAND"/>
      # <guildInfo>
      #   <guild>
      #     <members filterField="" filterValue="" maxPage="1" memberCount="1" page="1" sortDir="a" sortField="">
      #       <character class="Paladin" classId="2" gender="Male" genderId="0" level="14" name="Sturky" race="Dwarf" raceId="3" rank="0" url="r=Stormrage&amp;n=Sturky"/>
      #     </members>
      #   </guild>
      # </guildInfo>
      class Full < Wowr::Armory::Guild::Base
        attr_reader :members, :name_url, :realm_url, :member_count

        def initialize(elem)
          super(elem)

          @name_url     = elem[:nameUrl]
          @realm_url    = elem[:realmUrl]

          # Guild/guild_id/guild_url not set for characters
          if (elem%'guildInfo')
            @member_count = (elem%'guildInfo'%'guild'%'members')[:memberCount].to_i || nil
            @members = {}
            (elem%'guildInfo'%'guild'%'members'/:character).each do |char|
              # TODO: Change to search character?
              members[char[:name]] = Character.new(char)
            end
          end
        end

      end
    end
  end
end
