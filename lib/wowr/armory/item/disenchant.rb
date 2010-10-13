module Wowr
  module Armory
    module Item
      # <item name="Void Crystal" minCount="1" maxCount="2" icon="inv_enchant_voidcrystal" type="Enchanting" level="70" dropRate="6" id="22450" quality="4"></item>
      class Disenchant < Wowr::Armory::Item::Base
        attr_reader :level, :type, :drop_rate, :min_count, :max_count, :quality
        # :name, :id, :icon,

        def initialize(elem, api = nil)
          super(elem, api)
          # @name       = elem[:name]
          # @id         = elem[:id].to_i
          # @icon       = elem[:icon]
          @level      = elem[:level].to_i
          @type       = elem[:type]
          @drop_rate  = elem[:dropRate].to_i
          @min_count  = elem[:minCount].to_i
          @max_count  = elem[:maxCount].to_i
          @quality    = elem[:quality].to_i
        end
      end
    end
  end
end
