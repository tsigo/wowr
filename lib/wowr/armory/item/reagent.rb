module Wowr
  module Armory
    module Item
      class Reagent < Wowr::Armory::Item::Base
        attr_reader :count

        def initialize(elem, api = nil)
          super(elem, api)
          # @id = elem[:id].to_i
          # @name = elem[:name]
          # @icon = elem[:icon]
          @count = elem[:count].to_i
        end
      end
    end
  end
end
