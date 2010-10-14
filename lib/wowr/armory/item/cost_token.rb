module Wowr
  module Armory
    module Item
      # <token icon="spell_holy_championsbond" id="29434" count="60"></token>
      class CostToken < Wowr::Armory::Item::Base
        attr_reader :count

        def initialize(elem, api = nil)
          super(elem)
          # @id = elem[:id].to_i
          # @icon_bse = elem[:icon]
          @count = elem[:count].to_i
        end
      end

    end
  end
end
