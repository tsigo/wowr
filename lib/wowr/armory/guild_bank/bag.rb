module Wowr
  module Armory
    module GuildBank
      class Bag < Wowr::Armory::GuildBank::Base
        attr_reader   :viewable
        attr_accessor :items

        def initialize(elem, api = nil)
          super(elem, api)
          @viewable = (@viewable == "true")

          @items = []
        end
      end
    end
  end
end
