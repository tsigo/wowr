module Wowr
  module Armory
    module Item
      # = Source
      #
      # Represents an <tt>itemSource</tt> element
      #
      # == Relevant XML example:
      #
      #   <itemSource areaId="2159" areaName="Onyxia's Lair" creatureId="10184" creatureName="Onyxia" difficulty="n" dropRate="6" value="sourceType.creatureDrop"/>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/item-tooltip.xml?i=49295
      # * http://www.wowarmory.com/item-tooltip.xml?i=50731
      class Source

        # @return [String]
        attr_reader :value

        # Area (zone) ID
        # @return [Integer]
        attr_reader :area_id

        # Area (zone) Name
        # @return [String]
        attr_reader :area_name

        # @return [Integer]
        attr_reader :creature_id

        # @return [String]
        attr_reader :creature_name

        # Normal ('n') or Heroic ('h')
        # @return [String]
        attr_reader :difficulty

        # Drop rates:
        # * 1 - ? (1%-2%)
        # * 2 - Very Low (3%-14%)
        # * 3 - Low (15%-24%)
        # * 4 - Medium (25%-50%)
        # * 5 - High (51%-99%)
        # * 6 - Guaranteed (100%)
        # @return [Integer]
        attr_reader :drop_rate

        # @param [Hpricot::Elem] elem <tt>itemSource</tt> element
        def initialize(elem)
          @value          = elem[:value]
          @area_id        = elem[:areaId].to_i     if elem[:areaId]
          @area_name      = elem[:areaName]        if elem[:areaName]
          @creature_id    = elem[:creatureId].to_i if elem[:creatureId]
          @creature_name  = elem[:creatureName]    if elem[:creatureName]
          @difficulty     = elem[:difficulty]      if elem[:difficulty]
          @drop_rate      = elem[:dropRate].to_i   if elem[:dropRate]
          @required_level = elem[:reqLvl].to_i     if elem[:reqLvl]
        end
      end
    end
  end
end
