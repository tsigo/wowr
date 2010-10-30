module Wowr
  module Armory
    module GuildBank
      class Bag < Wowr::Armory::GuildBank::Base
        attr_reader   :viewable
        attr_accessor :items

        def initialize(elem, api = nil)
          super(elem, api)
          @viewable = (@viewable == "true") # FIXME: What exactly is the point of this? (tsigo)

          @items = []
        end
      end
    end
  end
end
