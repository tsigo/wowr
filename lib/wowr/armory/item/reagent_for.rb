module Wowr
  module Armory
    module Item
      # = ReagentFor
      #
      # Represents a <tt>reagentFor/spell</tt> element
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
      class ReagentFor < Base
        # @return [Created]
        attr_reader :item

        # @return [Array] Array of {Reagent} instances
        attr_reader :reagents

        # @param [Nokogiri::XML::Element] elem <tt>spell</tt> element
        # @param [Wowr::API::API] api
        def initialize(elem, api = nil)
          super(elem, api)

          @item = Created.new(elem%'item') if (elem%'item')

          @reagents = []
          if (elem%'reagent')
            (elem/:reagent).each do |reagent|
              @reagents << Reagent.new(reagent, api)
            end
          end
        end
      end
    end
  end
end
