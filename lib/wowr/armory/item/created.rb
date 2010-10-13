module Wowr
  module Armory
    module Item
      # <item name="Shadowprowler's Chestguard" icon="inv_chest_plate11" type="Leather" level="105" id="33204" quality="4"></item>
      class Created < Wowr::Armory::Item::Base
        attr_reader :type, :level, :quality

        def initialize(elem, api = nil)
          super(elem, api)
          @type = elem[:type]
          @level = elem[:level].to_i
          @quality = elem[:quality].to_i
        end
      end
    end
  end
end
