module Wowr
  module Armory
    module Item
      # Represents an item containing full information from both item-info and
      # item-tooltip pages
      class Full < Wowr::Armory::Item::Base
        def initialize(info, tooltip, api = nil)
          super(info, api)
          @info = Info.new(info, api)
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
