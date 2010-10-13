module Wowr
  module Armory
    module Item
      # Most basic
      # Composed of an ItemInfo and
      # Needs to be consolidated with ItemInfo and other stuff
      # to be a parent class that they extend?
      # TODO: At the moment needs a reference to the API in order to get the base URL for icons
      # TODO: Make extend Icon class
      class Base
        attr_reader :id, :name, :icon_base
        alias_method :item_id, :id
        alias_method :to_s, :name
        alias_method :to_i, :id

        @@icon_url_base = 'wow-icons/_images/'
        @@icon_url_base_tw = 'wow-icons/_images/'
        @@icon_sizes = {:large => ['64x64', 'jpg'], :medium => ['43x43', 'png'], :small => ['21x21', 'png']}

        def initialize(elem, api = nil)
          @api = api

          @id         = elem[:id].to_i
          @name       = elem[:name]
          @icon_base  = elem[:icon]
        end

        def icon(size = :medium)
          if !@@icon_sizes.include?(size)
            raise Wowr::Exceptions::InvalidIconSize.new(@@icon_sizes)
          end

          if @api
            base = @api.base_url
          else
            base = 'http://www.wowarmory.com/'
          end

          if @api && @api.locale == "tw"
            url_base = @@icon_url_base_tw
          else
            url_base = @@icon_url_base
          end

          # http://www.wowarmory.com/images/icons/64x64/blahblah.jpg
          return base + url_base + @@icon_sizes[size][0] + '/' + @icon_base + '.' + @@icon_sizes[size][1]
        end
      end
    end
  end
end
