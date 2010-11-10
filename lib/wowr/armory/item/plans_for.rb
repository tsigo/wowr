module Wowr
  module Armory
    module Item
      # <plansFor>
      #   <spell name="Shadowprowler's Chestguard" icon="trade_leatherworking" id="42731">
      #     <item name="Shadowprowler's Chestguard" icon="inv_chest_plate11" type="Leather" level="105" id="33204" quality="4"></item>
      #     <reagent name="Heavy Knothide Leather" icon="inv_misc_leatherscrap_11" id="23793" count="10"></reagent>
      #   </spell>
      # </plansFor>
      # FIXME: I cannot find "plansFor" anywhere on the Armory. Has it been removed? (tsigo)
      #        Update: I think it's been replaced by <tt>reagentFor</tt> - see http://www.wowarmory.com/item-info.xml?i=17204
      class PlansFor < Wowr::Armory::Item::Creation
        def initialize(elem, api = nil)
          super(elem, api)
          # TODO: Multiple items?
          @item = CreatedItem.new(elem%'item') if (elem%'item')
        end
      end
    end
  end
end
