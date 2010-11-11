module Wowr
  module Armory
    module Item
      # = Cost
      #
      # Represents a <tt>cost</tt> element. If any child <tt>token</tt>
      # elements are present, those will be added to the {tokens} attribute.
      #
      # == Relevant XML example:
      #
      #   <cost buyPrice="137714" sellPrice="27542">
      #     <token count="20" icon="inv_misc_rune_08" id="26045"/>
      #     <token count="1" icon="inv_misc_rune_09" id="26044"/>
      #   </cost>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/item-info.xml?i=17204
      # * http://www.wowarmory.com/item-info.xml?i=27644
      # * http://www.wowarmory.com/item-info.xml?i=27679
      class Cost
        # @return [Wowr::Classes::Money]
        attr_reader :buy_price

        # @return [Wowr::Classes::Money]
        attr_reader :sell_price

        # @return [Array] Array of {CostToken} instances
        attr_reader :tokens

        # @return [Wowr::Classes::Money]
        attr_reader :honor_price

        # @return [Wowr::Classes::Money]
        attr_reader :arena_price

        # @param [Hpricot::Elem] elem <tt>cost</tt> element
        def initialize(elem)
          @honor_price = Wowr::Classes::Money.new(elem[:honor].to_i)     if elem[:honor]
          @arena_price = Wowr::Classes::Money.new(elem[:arena].to_i)     if elem[:arena]
          @buy_price   = Wowr::Classes::Money.new(elem[:buyPrice].to_i)  if elem[:buyPrice]
          @sell_price  = Wowr::Classes::Money.new(elem[:sellPrice].to_i) if elem[:sellPrice]

          @tokens = []
          if (elem%'token')
            (elem/:token).each do |token|
              @tokens << CostToken.new(token)
            end
          end
        end
      end
    end
  end
end
