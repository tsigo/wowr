module Wowr
  module Armory
    module Item
      # TODO: At the moment needs a reference to the API in order to get the base URL for icons
      # TODO: Make extend Icon class

      # = Base
      #
      # The most basic item information. Represents any <tt>item</tt> element
      # that has <tt>id</tt>, <tt>name</tt> and <tt>icon</tt> attributes.
      #
      # == Relevant XML example:
      #
      #   <item icon="inv_mace_82" id="40395" level="226" name="Torch of Holy Fire" quality="4" type="One-Handed Maces">
      class Base
        # @return [Integer]
        attr_reader :id

        # @return [String]
        attr_reader :name

        # @return [String]
        attr_reader :icon_base

        alias_method :item_id, :id
        alias_method :to_s, :name
        alias_method :to_i, :id

        @@icon_url_base    = 'wow-icons/_images/'.freeze
        @@icon_url_base_tw = 'wow-icons/_images/'.freeze

        # @param [Nokogiri::XML::Element] elem <tt>item</tt> element
        # @param [Wowr::API::API] api
        def initialize(elem, api = nil)
          @api = api

          @id         = elem[:id].to_i
          @name       = elem[:name]
          @icon_base  = elem[:icon]
        end

        # Get the full URL to this item's icon
        #
        # @param [Symbol] size <tt>:large</tt>, <tt>:medium</tt> or <tt>:small</tt>
        # @return [String] Icon URL
        def icon(size = :medium)
          sizes = { :large => ['64x64', 'jpg'], :medium => ['43x43', 'png'], :small => ['21x21', 'png'] }

          raise Wowr::Exceptions::InvalidIconSize.new(sizes) unless sizes.include?(size)

          base = @api ? @api.base_url : 'http://www.wowarmory.com/'

          if @api && @api.locale == "tw"
            url_base = @@icon_url_base_tw
          else
            url_base = @@icon_url_base
          end

          # http://www.wowarmory.com/images/icons/64x64/blahblah.jpg
          return base + url_base + sizes[size][0] + '/' + @icon_base + '.' + sizes[size][1]
        end
      end
    end
  end
end
