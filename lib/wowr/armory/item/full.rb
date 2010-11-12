module Wowr
  module Armory
    module Item
      # = Full
      #
      # Acts as a gateway for a complete item, containing information from both
      # <tt>item-info.xml</tt> and <tt>item-tooltip.xml</tt> pages
      #
      # @see {Info}
      # @see {Tooltip}
      class Full < Base
        # @param [Nokogiri::XML::Element] info <tt>itemInfo/item</tt> element
        # @param [Nokogiri::XML::Element] tooltip <tt>itemTooltip</tt> element
        # @param [Wowr::API::API] api
        def initialize(info, tooltip, api = nil)
          super(info, api)

          @info    = Info.new(info, api)
          @tooltip = Tooltip.new(tooltip, api)
        end

        def method_missing(m, *args)
          if @info.respond_to? m
            return @info.send(m, *args)
          elsif @tooltip.respond_to? m
            return @tooltip.send(m, *args)
          else
            super
          end
        end
      end
    end
  end
end
