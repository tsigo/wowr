module Wowr
  module Armory
    module Character
      # = EquippedItem
      #
      # Represents an <tt>item</tt> element in a character's <tt>items</tt> element
      #
      # == Relevant XML examples:
      #
      #   <item durability="45" gem0Id="41398" gem1Id="52220" gem2Id="0" id="58123" permanentenchant="4209" pickUp="" putDown="" randomPropertiesId="0" seed="0" slot="0"/>
      #
      #   <item durability="0" gem0Id="0" gem1Id="0" gem2Id="0" id="62378" permanentenchant="0" pickUp="" putDown="" randomPropertiesId="0" seed="0" slot="1"/>
      #
      #   <item durability="42" gem0Id="52219" gem1Id="0" gem2Id="0" id="58124" permanentenchant="4205" pickUp="" putDown="" randomPropertiesId="0" seed="0" slot="2"/>
      #
      #   <item durability="94" gem0Id="52212" gem1Id="52220" gem2Id="0" id="59119" permanentenchant="3832" pickUp="" putDown="" randomPropertiesId="0" seed="0" slot="4"/>
      class EquippedItem < Wowr::Armory::Item::Base
        # @return [Integer]
        attr_reader :durability

        # @return [Array] Array of Gem IDs
        attr_reader :gems

        # The ID of the effect of the enchant
        # @note This is not the ID of the item that provides the enchant
        # @return [Integer]
        attr_reader :permanent_enchant

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
          @random_properties_id      = elem[:randomPropertiesId] == 0 ? nil : elem[:randomPropertiesId].to_i
          @seed                      = elem[:seed].to_i # not sure if seed is so big it's overloading
          @slot                      = elem[:slot].to_i
        end
      end
    end
  end
end
