module Wowr
  module Armory
    module Item
      # TODO: Rename
      class Quest
        attr_reader :name, :id, :level, :min_level, :area, :suggested_party_size

        def initialize(elem)
          @name                 = elem[:name]
          @id                   = elem[:id].to_i
          @level                = elem[:level].to_i
          @min_level            = elem[:reqMinLevel].to_i
          @area                 = elem[:area]
          @suggested_party_size = elem[:suggestedPartySize].to_i
        end
      end
    end
  end
end
