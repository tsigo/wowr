module Wowr
  module Armory
    module Item
      # Represents a <tt><creature></tt> element that drops an item
      #
      # == Relevant XML example:
      #
      #   <creature area="Molten Core" areaUrl="fl[source]=dungeon&amp;fl[dungeon]=moltencore&amp;fl[boss]=all&amp;fl[difficulty]=all" classification="3" dropRate="2" heroic="1" id="11502" maxLevel="63" minLevel="63" name="Ragnaros" type="Elemental" url="fl[source]=dungeon&amp;fl[dungeon]=moltencore&amp;fl[difficulty]=heroic&amp;fl[boss]=11502"/>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/item-info.xml?i=17204
      class DropCreature
        # @return [String]
        attr_reader :name

        # @return [Integer]
        attr_reader :id

        # @example
        #   "Humanoid"
        #   "Elemental"
        # @return [String]
        attr_reader :type

        # @return [Integer]
        attr_reader :min_level

        # @return [Integer]
        attr_reader :max_level

        # Drop rates:
        # * 1 - ? (1%-2%)
        # * 2 - Very Low (3%-14%)
        # * 3 - Low (15%-24%)
        # * 4 - Medium (25%-50%)
        # * 5 - High (51%-99%)
        # * 6 - Guaranteed (100%)
        # @return [Integer]
        attr_reader :drop_rate

        # @return [Integer]
        attr_reader :classification

        # @return [String]
        attr_reader :area

        def initialize(elem)
          @name           = elem[:name]
          @id             = elem[:id].to_i
          @min_level      = elem[:minLevel].to_i
          @max_level      = elem[:maxLevel].to_i
          @drop_rate      = elem[:dropRate].to_i
          @classification = elem[:classification].to_i
          @area           = elem[:area]

          # optional boss stuff
          @title    = elem[:title]    if elem[:title] # TODO: not nil when no property?
          @url      = elem[:url]      if elem[:url]
          @type     = elem[:type]     if elem[:type] # Humanoid etc.
          @area_url = elem[:areaUrl]  if elem[:areaUrl]
        end
      end
    end
  end
end
