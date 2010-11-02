module Wowr
  module Armory
    module Guild
      # Represents a full <tt>guild-info.xml</tt> page
      #
      # == Relevant XML example
      #
      #   <guildInfo>
      #     <guildHeader battleGroup="Stormstrike" count="122" faction="1" name="Juggernaut" nameUrl="Juggernaut" realm="Mal'Ganis" realmUrl="Mal%27Ganis" url="r=Mal%27Ganis&amp;gn=Juggernaut">
      #       <emblem emblemBackground="4" emblemBorderColor="15" emblemBorderStyle="1" emblemIconColor="15" emblemIconStyle="84"/>
      #     </guildHeader>
      #     <guild>
      #       <members memberCount="122">
      #         <character achPoints="9930" classId="2" genderId="1" level="80" name="Grim" raceId="10" rank="3" url="r=Mal%27Ganis&amp;cn=Grim"/>
      #         <character achPoints="9730" classId="4" genderId="0" level="80" name="Baud" raceId="2" rank="1" url="r=Mal%27Ganis&amp;cn=Baud"/>
      #         <character achPoints="0" classId="7" genderId="0" level="70" name="Muroka" raceId="2" rank="3" url="r=Mal%27Ganis&amp;cn=Muroka"/>
      #         <character achPoints="5505" classId="11" genderId="0" level="80" name="Baudz" raceId="6" rank="1" url="r=Mal%27Ganis&amp;cn=Baudz"/>
      #       </members>
      #     </guild>
      #   </guildInfo>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/guild-info.xml?gn=Goon+Squad&r=Mal%27Ganis
      # * http://www.wowarmory.com/guild-info.xml?gn=Juggernaut&r=Mal%27Ganis
      # * http://www.wowarmory.com/guild-info.xml?gn=Vigil&r=Mal%27Ganis
      #
      # @see Base
      class Full < Wowr::Armory::Guild::Base
        # Hash of <tt>"MemberName" => Character</tt> pairs
        # @see Wowr::Classes::Character
        # @return [Hash]
        attr_reader :members

        # Parameterized name
        # @example
        #   "Goon+Squad"
        # @return [String]
        attr_reader :name_url

        # Paramterized realm name
        # @example
        #   "Mal%27Ganis"
        # @return [String]
        attr_reader :realm_url

        # Number of members
        # @return [Integer]
        attr_reader :member_count

        def initialize(elem)
          super(elem)

          @name_url     = (elem%'guildHeader')[:nameUrl]
          @realm_url    = (elem%'guildHeader')[:realmUrl]

          # Guild/guild_id/guild_url not set for characters
          if (elem%'guildInfo')
            @member_count = (elem%'guildInfo'%'guild'%'members')[:memberCount].to_i || nil
            @members = {}
            (elem%'guildInfo'%'guild'%'members'/:character).each do |char|
              # TODO: Change to search character?
              members[char[:name]] = Wowr::Classes::Character.new(char)
            end
          end
        end

      end
    end
  end
end
