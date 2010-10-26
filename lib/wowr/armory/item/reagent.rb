module Wowr
  module Armory
    module Item
      class Reagent < Wowr::Armory::Item::Base
        attr_reader :count

        def initialize(elem, api = nil)
          super(elem, api)
          @count = elem[:count].to_i
        end
      end
    end
  end
end
