module Wowr
  module Armory
    module Item
      # Represents a single <tt><item></tt> element returned by an item search
      #
      # == Relevant XML example:
      #
      #   <item icon="inv_boots_plate_09" id="45218" name="Blood-Caked Stompers" rarity="3" url="i=45218">
      #     <filter name="itemLevel" value="200"/>
      #     <filter name="source" value="sourceType.vendor"/>
      #     <filter name="relevance" value="100"/>
      #   </item>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/search.xml?searchQuery=cake&searchType=items
      class SearchResult < Wowr::Armory::Item::Base
        # URL parameters for the item
        # @example
        #   "i=45218"
        # @return [String]
        attr_reader :url

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
        attr_reader :rarity

        # sourceType string
        # @example
        #   "sourceType.vendor"
        #   "sourceType.creature"
        # @return [String]
        attr_reader :source

        # @return [Integer]
        attr_reader :item_level

        # Search relevance
        # @return [Integer]
        attr_reader :relevance

        alias_method :level, :item_level

        def initialize(elem, api = nil)
          super(elem, api)
          @rarity     = elem[:rarity].to_i
          @url        = elem[:url]

          @item_level = elem.at("filter[@name='itemLevel']")[:value].to_i
          @source     = elem.at("filter[@name='source']")[:value]
          @relevance  = elem.at("filter[@name='relevance']")[:value].to_i
        end
      end
    end
  end
end
