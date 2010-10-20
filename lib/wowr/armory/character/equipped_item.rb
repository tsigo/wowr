module Wowr
  module Armory
    module Character
      # An item equipped to a player
      class EquippedItem < Wowr::Classes::Item
        attr_reader :durability, :max_durability, #:id, :item_id, :icon,
                    :gems, :permanent_enchant,
                    :random_properties_id, :seed, :slot

        def initialize(elem, api = nil)
          super(elem, api)
          @durability           = elem[:durability].to_i
          @max_durability       = elem[:maxDurability].to_i
          @gems = []
          @gems[0]              = elem[:gem0Id].to_i == 0 ? nil : elem[:gem0Id].to_i
          @gems[1]              = elem[:gem1Id].to_i == 0 ? nil : elem[:gem1Id].to_i
          @gems[2]              = elem[:gem2Id].to_i == 0 ? nil : elem[:gem2Id].to_i
          @permanent_enchant    = elem[:permanentenchant].to_i
          @random_properties_id = elem[:randomPropertiesId] == 0 ? nil : elem[:randomPropertiesId].to_i
          @seed                 = elem[:seed].to_i # not sure if seed is so big it's overloading
          @slot                 = elem[:slot].to_i
        end
      end
    end
  end
end
