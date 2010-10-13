module Wowr
  module Armory
    module Item
      # A really basic item type returned by searches
      class Search < Wowr::Armory::Item::Base
        attr_reader :url, :rarity,
          :source, :item_level, :relevance
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
