module Wowr
  module Armory
    module Item
      class Spell
        attr_reader :trigger, :description
        alias_method :desc, :description
        alias_method :to_s, :description

        def initialize(elem)
          @trigger = (elem%'trigger').html.to_i
          @description = (elem%'desc').html
        end
      end
    end
  end
end
