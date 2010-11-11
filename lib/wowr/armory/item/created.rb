module Wowr
  module Armory
    module Item
      # = Created
      #
      # Represents a <tt>reagentFor/spell/item</tt> element
      #
      # == Relevant XML example:
      #
      #   <reagentFor>
      #     <spell icon="spell_shadow_sealofkings" id="21160" name="Eye of Sulfuras">
      #       <item icon="inv_hammer_unique_sulfuras" id="17182" level="80" name="Sulfuras, Hand of Ragnaros" quality="5" type="Two-Handed Maces"/>
      #       <reagent count="1" icon="inv_hammer_unique_sulfuras" id="17193" name="Sulfuron Hammer" quality="4"/>
      #       <reagent count="1" icon="inv_misc_gem_pearl_05" id="17204" name="Eye of Sulfuras" quality="5"/>
      #     </spell>
      #   </reagentFor>
      class Created < Base
        # @example
        #   "Two-Handed Maces"
        # @return [String]
        attr_reader :type

        # @return [Integer]
        attr_reader :level

        # Item rarity (quality)
        # * 0 - Trash (Grey)
        # * 1 - Common (White)
        # * 2 - Uncommon (Green)
        # * 3 - Rare (Blue)
        # * 4 - Epic (Purple)
        # * 5 - Legendary (Orange)
        # * 6
        # * 7 - Heirloom (Gold)
        # @return [Integer]
        attr_reader :quality

        # @param [Hpricot::Elem] elem <tt>item</tt> element
        # @param [Wowr::API::API] api
        def initialize(elem, api = nil)
          super(elem, api)

          @type    =  elem[:type]
          @level   =  elem[:level].to_i
          @quality =  elem[:quality].to_i
        end
      end
    end
  end
end
