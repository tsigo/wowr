module Wowr
  module Armory
    module Item
      # = SearchResult
      #
      # Represents a single <tt>item</tt> element returned by an item search
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

        # @see Wowr::Armory#quality
        # @return [Integer]
        attr_reader :quality

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
        alias_method :rarity, :quality

        # @param [Hpricot::Elem] elem <tt>item</tt> element
        # @param [Wowr::API::API] api
        def initialize(elem, api = nil)
          super(elem, api)

          @quality    = elem[:rarity].to_i
          @url        = elem[:url]
          @item_level = elem.at("filter[@name='itemLevel']")[:value].to_i
          @source     = elem.at("filter[@name='source']")[:value]
          @relevance  = elem.at("filter[@name='relevance']")[:value].to_i
        end
      end
    end
  end
end
