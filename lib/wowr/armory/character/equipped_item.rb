module Wowr
  module Armory
    module Character
      # = EquippedItem
      #
      # Represents an <tt>item</tt> element in a character's <tt>items</tt> element
      #
      # == Relevant XML examples:
      #
      #   <item displayInfoId="65131" durability="100" gem0Id="41398" gem1Id="40112" gem2Id="0" gemIcon0="inv_jewelcrafting_shadowspirit_02" gemIcon1="inv_jewelcrafting_gem_37" icon="inv_helmet_158" id="51286" level="277" maxDurability="100" name="Sanctified Ahn'Kahar Blood Hunter's Headpiece" permanentEnchantIcon="ability_warrior_rampage" permanentEnchantItemId="44149" permanentenchant="3817" pickUp="PickUpSmallChain" putDown="PutDownSmallChain" randomPropertiesId="0" rarity="4" seed="0" slot="0"/>
      #
      #   <item displayInfoId="64216" durability="0" gem0Id="40157" gem1Id="0" gem2Id="0" gemIcon0="inv_jewelcrafting_gem_40" icon="inv_misc_monsterhorn_03" id="50633" level="277" maxDurability="0" name="Sindragosa's Cruel Claw" permanentenchant="0" pickUp="PickUpRing" putDown="PutDownRing" randomPropertiesId="0" rarity="4" seed="1348559296" slot="1"/>
      #
      #   <item displayInfoId="64829" durability="100" gem0Id="40112" gem1Id="0" gem2Id="0" gemIcon0="inv_jewelcrafting_gem_37" icon="inv_shoulder_113" id="51288" level="277" maxDurability="100" name="Sanctified Ahn'Kahar Blood Hunter's Spaulders" permanentEnchantIcon="inv_axe_85" permanentEnchantItemId="44871" permanentenchant="3808" pickUp="PickUpSmallChain" putDown="PutDownSmallChain" randomPropertiesId="0" rarity="4" seed="0" slot="2"/>
      #
      #   <item displayInfoId="64840" durability="165" gem0Id="40112" gem1Id="40157" gem2Id="0" gemIcon0="inv_jewelcrafting_gem_37" gemIcon1="inv_jewelcrafting_gem_40" icon="inv_chest_mail_11" id="51289" level="277" maxDurability="165" name="Sanctified Ahn'Kahar Blood Hunter's Tunic" permanentEnchantIcon="inv_scroll_03" permanentEnchantItemId="44465" permanentenchant="3832" pickUp="PickUpSmallChain" putDown="PutDownSmallChain" randomPropertiesId="0" rarity="4" seed="0" slot="4"/>
      class EquippedItem < Wowr::Armory::Item::Base
        # @return [Integer]
        attr_reader :durability

        # @return [Integer]
        attr_reader :max_durability

        # @return [Array] Array of Gem IDs
        attr_reader :gems

        # The ID of the effect of the enchant
        # @note This is not the ID of the item that provides the enchant
        # @return [Integer]
        attr_reader :permanent_enchant

        # The ID of the item providing the enchant
        # @return [Integer]
        attr_reader :permanent_enchant_item_id

        # @return [Integer]
        attr_reader :random_properties_id

        # @todo Unknown purpose
        # @return [Integer]
        attr_reader :seed

        # @return [Integer]
        attr_reader :slot

        def initialize(elem, api = nil)
          super(elem, api)
          @durability                = elem[:durability].to_i
          @max_durability            = elem[:maxDurability].to_i
          @gems                      = []
          @gems[0]                   = elem[:gem0Id].to_i == 0 ? nil : elem[:gem0Id].to_i
          @gems[1]                   = elem[:gem1Id].to_i == 0 ? nil : elem[:gem1Id].to_i
          @gems[2]                   = elem[:gem2Id].to_i == 0 ? nil : elem[:gem2Id].to_i
          @permanent_enchant         = elem[:permanentenchant].to_i
          @permanent_enchant_item_id = elem[:permanentEnchantItemId].to_i
          @random_properties_id      = elem[:randomPropertiesId] == 0 ? nil : elem[:randomPropertiesId].to_i
          @seed                      = elem[:seed].to_i # not sure if seed is so big it's overloading
          @slot                      = elem[:slot].to_i
        end
      end
    end
  end
end
