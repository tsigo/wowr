module Wowr
  module Armory
    module Item
      class SetData
        attr_reader :name, :items, :set_bonuses
        alias_method :to_s, :name

        def initialize(elem)
          @name = elem[:name]

          @items = []
          (elem/:item).each do |item|
            @items << item[:name]
          end

          @set_bonuses = []
          (elem/:setBonus).each do |bonus|
            @set_bonuses << ItemSetBonus.new(bonus)
          end
        end
      end
    end
  end
end
