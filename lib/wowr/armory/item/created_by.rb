module Wowr
  module Armory
    module Item
      # TODO: Remove this class? The <item> element has been removed on the Armory (tsigo)
      # See http://www.wowarmory.com/item-info.xml?i=25897
      # <createdBy>
      #   <spell name="Bracing Earthstorm Diamond" icon="temp" id="32867">
      #     <item requiredSkill="Jewelcrafting" name="Design: Bracing Earthstorm Diamond" icon="inv_scroll_03" type="Jewelcrafting" level="73" id="25903" requiredSkillRank="365" quality="1"></item>
      #     <reagent name="Earthstorm Diamond" icon="inv_misc_gem_diamond_04" id="25867" count="1"></reagent>
      #   </spell>
      # </createdBy>
      class CreatedBy < Wowr::Armory::Item::Creation
        def initialize(elem, api = nil)
          super(elem, api)
          # TODO: Multiple items?
          @item = PlanItem.new(elem%'item') if (elem%'item')
        end
      end
    end
  end
end
