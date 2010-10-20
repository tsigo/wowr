module Wowr
  module Armory
    module Character
      # TODO: Code duplication, see basic Item class. Make extend Icon class?
      class Buff
        attr_reader :name, :effect, :icon_base
        alias_method :to_s, :name

        @@icon_url_base = 'images/icons/'
        @@icon_sizes = {:large => ['64x64', 'jpg'], :medium => ['43x43', 'png'], :small => ['21x21', 'png']}

        def initialize(elem, api = nil)
          @api = api

          @name       = elem[:name]
          @effect     = elem[:effect]
          @icon_base  = elem[:icon]
        end

        # http://armory.worldofwarcraft.com/images/icons/21x21/spell_holy_arcaneintellect.png
        def icon(size = :medium)
          if !@@icon_sizes.include?(size)
            raise Wowr::Exceptions::InvalidIconSize.new(@@icon_sizes)
          end

          if @api
            base = @api.base_url
          else
            base = 'http://www.wowarmory.com/'
          end

          # http://www.wowarmory.com/images/icons/64x64/blahblah.jpg
          return base + @@icon_url_base + @@icon_sizes[size][0] + '/' + @icon_base + '.' + @@icon_sizes[size][1]
        end
      end
    end
  end
end
