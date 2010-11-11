module Wowr
  module Armory
    module Item
      # = SetData
      #
      # Represents a <tt>setData</tt> element
      #
      # == Relevant XML example:
      #
      #   <setData>
      #     <name>Sanctification Garb</name>
      #     <item name="Circlet of Sanctification"/>
      #     <item name="Handwraps of Sanctification"/>
      #     <item name="Mantle of Sanctification"/>
      #     <item name="Pants of Sanctification"/>
      #     <item name="Raiments of Sanctification"/>
      #     <setBonus desc="Increases the damage done by your Devouring Plague by 15%." threshold="2"/>
      #     <setBonus desc="Your Mind Blast also grants you 240 haste rating for 4 sec." threshold="4"/>
      #   </setData>
      class SetData
        # @example
        #   "Sanctification Garb"
        # @return [String]
        attr_reader :name

        # @example
        #   ["Circlet of Sanctification", "Handwraps of Sanctification", ...]
        # @return [Array] Array of strings
        attr_reader :items

        # @return [Array] Array of {SetBonus} instances
        attr_reader :set_bonuses

        alias_method :to_s, :name

        # @param [Hpricot::Elem] elem <tt>setData</tt> element
        def initialize(elem)
          @name = (elem/:name).text

          @items = []
          (elem/:item).each do |item|
            @items << item[:name]
          end

          @set_bonuses = []
          (elem/:setBonus).each do |bonus|
            @set_bonuses << SetBonus.new(bonus)
          end
        end
      end
    end
  end
end
