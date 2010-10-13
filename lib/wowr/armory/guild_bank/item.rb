module Wowr
  module Armory
    module GuildBank
      # More detailed item used in full Wowr::Classes::GuildBank
      # Very close to Wowr::Classes::EquippedItem
      # <item bag="0" durability="0" icon="racial_dwarf_findtreasure" id="12219" maxDurability="0" name="Unadorned Seal of Ascension" qi="1" quantity="1" randomPropertiesId="0" seed="1827537860" slot="90" subtype="" subtypeLoc="Quest" type="consumables"/>
      class Item < Wowr::Armory::Item::Base
        attr_reader :bag_id, :durability, :max_durability, :qi, :quantity,
          :random_properties_id, :seed, :slot, :subtype, :subtype_loc, :type

        def initialize(elem, bags = nil, api = nil)
          super(elem, api)

          @bag_id   = elem[:bag].to_i
          @qi       = elem[:qi].to_i
          @quantity = elem[:quantity].to_i

          @durability           = elem[:durability].to_i
          @max_durability       = elem[:maxDurability].to_i
          @random_properties_id = elem[:randomPropertiesId] == 0 ? nil : elem[:randomPropertiesId].to_i
          @seed         = elem[:seed].to_i
          @slot         = elem[:slot].to_i
          @subtype      = elem[:subtype]    == "" ? nil : elem[:subtype]
          @subtype_loc  = elem[:subtypeLoc] == "" ? nil : elem[:subtypeLoc]
          @type         = elem[:type].to_i

          bags[@bag_id].items << self
        end
      end
    end
  end
end
