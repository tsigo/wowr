module Wowr
  module Armory
    module Item
      class SetBonus
        attr_reader :threshold, :description
        alias_method :desc, :description
        alias_method :to_s, :description

        def initialize(elem)
          @threshold = elem[:threshold].to_i
          @description = elem[:desc]
        end
      end
    end
  end
end
