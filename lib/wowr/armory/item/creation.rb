module Wowr
  module Armory
    module Item
      # TODO rename
      # There is some sort of opposite relationship between PlansFor and CreatedBy
      class Creation < Wowr::Armory::Item::Base

        # FIXME: item attribute is never assigned to; working as intended? (tsigo)
        attr_reader :item, :reagents

        def initialize(elem, api = nil)
          super(elem, api)

          if (elem%'reagent')
            @reagents = []
            (elem/:reagent).each do |reagent|
              @reagents << Reagent.new(reagent, api)
            end
          end
        end
      end
    end
  end
end
