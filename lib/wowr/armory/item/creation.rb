module Wowr
  module Armory
    module Item
      # TODO rename
      class Creation < Wowr::Armory::Item::Base

        # NOTE: item is assigned by PlansFor, which subclasses Creation
        # This seems like bad, confusing design. Why doesn't PlansFor just
        # define the item attribute?

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
