module Wowr
  module Armory
    module Item
      # uses item-info.xml
      class Info < Wowr::Armory::Item::Base
        attr_reader :level, :quality, :type,
          :cost, :disenchant_items, :disenchant_skill_rank, :vendors,
          :objective_of_quests,
          :reward_from_quests,
          :drop_creatures,
          :plans_for, :created_by

        alias_method :disenchants, :disenchant_items

        def initialize(elem, api = nil)
          super(elem, api)

          @level    = elem[:level].to_i
          @quality  = elem[:quality].to_i
          @type     = elem[:type]

          # Cost can be in gold, or tokens
          @cost = Wowr::Classes::ItemCost.new(elem%'cost') if (elem%'cost')

          # is costs really an array?
          #@costs     = []
          #(elem/:cost).each do |cost|
          # @costs << ItemCost.new(cost)
          #end

          etc = [
            # xml element name,   member variable         item list class name,   requires api link
            ['disenchantLoot',    '@disenchant_items',    'item',     Wowr::Classes::DisenchantItem, true],
            ['objectiveOfQuests', '@objective_of_quests', 'quest',    Wowr::Classes::ItemQuest, false],
            ['rewardFromQuests',  '@reward_from_quests',  'quest',    Wowr::Classes::ItemQuest, false],
            ['vendors',           '@vendors',             'creature', Wowr::Classes::ItemVendor, false],
            ['dropCreatures',     '@drop_creatures',      'creature', Wowr::Classes::ItemDropCreature, false],
            ['plansFor',          '@plans_for',           'spell',    Wowr::Classes::ItemPlansFor, true],
            ['createdBy',         '@created_by',          'spell',    Wowr::Classes::ItemCreatedBy, true],
          ]

          etc.each do |b|
            ele = b[0]
            var = b[1]
            list = b[2]
            my_class = b[3]
            requires_api = b[4]

            if elem%ele
              tmp_arr = []
              (elem%ele/list).each do |x|
                if requires_api
                  tmp_arr << my_class.new(x, api)
                else
                  tmp_arr << my_class.new(x)
                end
              end
              self.instance_variable_set(var, tmp_arr)
            end
          end

          # Rest of disenchant contents is done in the method above
          if (elem%'disenchantLoot')
            @disenchant_skill_rank = (elem%'disenchantLoot')[:requiredSkillRank].to_i
          end
        end
      end
    end
  end
end
