module Wowr
  module Armory
    module Item
      class Source
        attr_reader :value,
          :area_id, :area_name,
          :creature_id, :creature_name,
          :difficulty, :drop_rate

        def initialize(elem)
          @value          = elem[:value]
          @area_id        = elem[:areaId].to_i      if elem[:areaId]
          @area_name      = elem[:areaName]         if elem[:areaName]
          @creature_id    = elem[:creatureId].to_i  if elem[:creatureId]
          @creature_name  = elem[:creatureName]     if elem[:creatureName]
          @difficulty     = elem[:difficulty]       if elem[:difficulty]
          @drop_rate      = elem[:dropRate].to_i    if elem[:dropRate]
          @required_level = elem[:reqLvl].to_i      if elem[:reqLvl]
        end
      end
    end
  end
end
