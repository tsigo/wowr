module Wowr
  module Armory
    module Item
      # Full data from item-info and item-tooltip
      class Full < Wowr::Armory::Item::Base
        def initialize(info, tooltip, api = nil)
          super(info, api)
          @info = ItemInfo.new(info, api)
          @tooltip = ItemTooltip.new(tooltip, api)
        end

        def method_missing(m, *args)
          begin
            return @info.send(m, *args)
          rescue NoMethodError => e
            begin
              return @tooltip.send(m, *args)
            rescue
              raise NoMethodError.new("undefined method '#{m}' for #{self.class}")
            end
          end
        end
      end
    end
  end
end
