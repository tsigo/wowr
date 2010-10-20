module Wowr
  module Armory
    module Character
      # eg Daggers, Riding, Fishing, language
      class Skill
        attr_reader :key, :name, :value, :max
        alias_method :to_s, :name
        alias_method :to_i, :value

        def initialize(elem)
          @key    = elem[:key]
          @name   = elem[:name]
          @value  = elem[:value].to_i
          @max    = elem[:max].to_i
        end
      end
    end
  end
end
