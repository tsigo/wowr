module Wowr
  module API
    module Items
      def self.included(base)
        base.class_eval do
          @@item_info_url    = 'item-info.xml'
          @@item_tooltip_url = 'item-tooltip.xml'

          cattr_accessor :item_info_url
          cattr_accessor :item_tooltip_url
        end
      end

      # Search for items with the specified name.
      # Returns an array of Wowr::Classes::SearchItem.
      # Searches across all realms.
      # Can search for items based upon the following options => :source, :dungeon, :item_type ("armor, weapon, etc"), :item_slot (head, shoulders, etc), and :item_sub_type (leather, mail, etc)
      # The dungeon param is the dungeon ID
      # Caching is disabled for searching.
      # * name (String) Name of the item
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.).
      def search_items(name, options = {})
        if (name.is_a?(Hash))
          options = name
        else
          options.merge!(:search => name)
        end

        options.merge!(:type => 'items')

        puts options.inspect if options[:debug]
        return search(options)
      end

      # Get the full item details (Wowr::Classes::FullItem) with the given id.
      # Composite of Wowr::Classes::ItemInfo and Wowr::Classes::ItemTooltip data.
      # Item requests are identical across realms.
      # * id (Fixnum) ID of the item
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def get_item(id, options = {})
        if (id.is_a?(Hash))
          options = id
        else
          options.merge!(:item_id => id)
        end

        options[:item_id] = options[:item_id].to_i
        options = merge_defaults(options)
        options.delete(:realm)

        info = get_xml(@@item_info_url, options)
        tooltip = get_xml(@@item_tooltip_url, options)

        if (info%'itemInfo'%'item') && !tooltip.nil?
          return Wowr::Classes::FullItem.new(info%'itemInfo'%'item', tooltip%'itemTooltip', self)
        else
          raise Wowr::Exceptions::ItemNotFound.new(options[:item_id])
        end
      end

      # Get the basic item information Wowr::Classes::ItemInfo.
      # Item requests are identical across realms.
      # * id (Fixnum) ID of the item
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def get_item_info(id, options = {})
        if (id.is_a?(Hash))
          options = id
        else
          options.merge!(:item_id => id)
        end

        options[:item_id] = options[:item_id].to_i
        options = merge_defaults(options)
        options.delete(:realm)

        xml = get_xml(@@item_info_url, options)

        if (xml%'itemInfo'%'item')
          return Wowr::Classes::ItemInfo.new(xml%'itemInfo'%'item', self)
        else
          raise Wowr::Exceptions::ItemNotFound.new(options[:item_id])
        end
      end

      # Get full item details including stats Wowr::Classes::ItemTooltip.
      # Item requests are identical across realms.
      # * id (Fixnum) ID of the item
      # * options (Hash) Optional hash of arguments identical to those used in the API constructor (realm, debug, cache etc.)
      def get_item_tooltip(id, options = {})
        if (id.is_a?(Hash))
          options = id
        else
          options.merge!(:item_id => id)
        end

        options[:item_id] = options[:item_id].to_i
        options = merge_defaults(options)
        options.delete(:realm)

        xml = get_xml(@@item_tooltip_url, options)

        if (xml%'itemTooltip')
          return Wowr::Classes::ItemTooltip.new(xml%'itemTooltip')
        else
          raise Wowr::Exceptions::ItemNotFound.new(options[:item_id])
        end
      end
    end
  end
end
