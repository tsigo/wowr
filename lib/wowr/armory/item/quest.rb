module Wowr
  module Armory
    module Item
      # <rewardFromQuests>
      #   <quest name="Justice Dispensed" level="39" reqMinLevel="30" id="11206" area="Dustwallow Marsh" suggestedPartySize="0"></quest>
      #   <quest name="Peace at Last" level="39" reqMinLevel="30" id="11152" area="Dustwallow Marsh" suggestedPartySize="0"></quest>
      # </rewardFromQuests>
      # TODO: Rename
      class Quest
        attr_reader :name, :id, :level, :min_level, :area, :suggested_party_size

        def initialize(elem)
          @name       = elem[:name]
          @id         = elem[:id].to_i
          @level      = elem[:level].to_i
          @min_level  = elem[:min_level].to_i
          @area       = elem[:area]
          @suggested_party_size = elem[:suggested_party_size].to_i
        end
      end
    end
  end
end
