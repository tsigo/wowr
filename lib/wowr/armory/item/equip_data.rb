module Wowr
  module Armory
    module Item
      class EquipData
        attr_reader :inventory_type, :subclass_name, :container_slots

        def initialize(elem)
          @inventory_type = (elem%'inventoryType').html.to_i
          @subclass_name = (elem%'subclassName').html if (elem%'subclassName')
          @container_slots = (elem%'containerSlots').html.to_i if (elem%'containerSlots') # for baggies
        end
      end
    end
  end
end
