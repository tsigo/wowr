module Wowr
  module Armory
    module Item
      class DamageData
        attr_reader :type, :min, :max, :speed, :dps

        def initialize(elem)
          @type   = (elem%'damage'%'type').html.to_i
          @min    = (elem%'damage'%'min').html.to_i
          @max    = (elem%'damage'%'max').html.to_i
          @speed  = (elem%'speed').html.to_f  if (elem%'speed')
          @dps    = (elem%'dps').html.to_f    if (elem%'dps')
        end
      end
    end
  end
end
