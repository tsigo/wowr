module Wowr
  module Armory
    module Item
      # = Info
      #
      # Represents a full <tt>itemInfo/item</tt> element from <tt>item-info.xml</tt> pages
      #
      # == Relevant XML example:
      #
      #   <item icon="inv_mace_82" id="40395" level="226" name="Torch of Holy Fire" quality="4" type="One-Handed Maces">
      #     <cost sellPrice="225096"/>
      #     <disenchantLoot requiredSkillRank="375">
      #       <item canAuction="1" dropRate="6" icon="inv_enchant_abysscrystal" id="34057" level="80" maxCount="1" minCount="1" name="Abyss Crystal" quality="4" type="Enchanting"/>
      #     </disenchantLoot>
      #     <dropCreatures>
      #       <creature area="Naxxramas" areaUrl="fl[source]=dungeon&amp;fl[dungeon]=naxxramas&amp;fl[boss]=all&amp;fl[difficulty]=all" classification="3" dropRate="3" heroic="1" id="30061" maxLevel="83" minLevel="83" name="Kel'Thuzad" type="Undead" url="fl[source]=dungeon&amp;fl[dungeon]=naxxramas&amp;fl[difficulty]=heroic&amp;fl[boss]=15990"/>
      #     </dropCreatures>
      #   </item>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/item-info.xml?i=40395
      # * http://www.wowarmory.com/item-info.xml?i=44434
      # * http://www.wowarmory.com/item-info.xml?i=49623
      #
      # @todo Explain differences between Tooltip and Info
      class Info < Base
        # @return [Integer]
        attr_reader :level

        # Item rarity (quality)
        # * 0 - Trash (Grey)
        # * 1 - Common (White)
        # * 2 - Uncommon (Green)
        # * 3 - Rare (Blue)
        # * 4 - Epic (Purple)
        # * 5 - Legendary (Orange)
        # * 6
        # * 7 - Heirloom (Gold)
        # @return [Integer]
        attr_reader :quality # FIXME: SearchResult calls this attribute 'rarity', here we call it 'quality' - normalize or alias

        # @example
        #   "One-Handed Maces"
        # @return [String]
        attr_reader :type

        # @return [Cost]
        attr_reader :cost

        # Any <tt>disenchantLoot/item</tt> elements
        # @return [Array] Array of {Disenchant} instances
        attr_reader :disenchant_items

        # If a <tt>disenchantLoot</tt> element exists, the required skill level to disenchant the item
        # @return [Integer]
        attr_reader :disenchant_skill_rank

        # Any <tt>vendors/creature</tt> elements
        # @return [Array] Array of {Vendor} instances
        attr_reader :vendors

        # Any <tt>objectiveOfQuests/quest</tt> elements
        # @return [Array] Array of {Quest} instances
        attr_reader :objective_of_quests

        # Any <tt>rewardFromQuests/quest</tt> elements
        # @return [Array] Array of {Quest} instances
        attr_reader :reward_from_quests

        # Any <tt>dropCreatures/creature</tt> elements
        # @return [Array] Array of {DropCreature} instances
        attr_reader :drop_creatures

        # @todo Unknown purpose
        # @return [Array]
        attr_reader :plans_for

        # @todo Unknown purpose
        # @todo Never assigned
        # @return [Unknown]
        attr_reader :created_by

        alias_method :disenchants, :disenchant_items

        # @param [Hpricot::Elem] elem <tt>itemInfo</tt> element
        # @param [Wowr::API::API] api
        def initialize(elem, api = nil)
          super(elem, api)

          @level    = elem[:level].to_i
          @quality  = elem[:quality].to_i
          @type     = elem[:type]

          # Cost can be in gold, or tokens
          @cost = Wowr::Classes::ItemCost.new(elem%'cost') if (elem%'cost')

          # NOTE: "cost" can look like one of the following: (tsigo)
          #
          # 17204:
          #   <cost sellPrice="200000"/>
          #
          # 27644:
          #   <cost buyPrice="137714" sellPrice="27542">
          #     <token count="20" icon="inv_misc_rune_08" id="26045"/>
          #     <token count="1" icon="inv_misc_rune_09" id="26044"/>
          #   </cost>
          #
          # 27679:
          #   <cost>
          #     <token count="100" icon="inv_misc_rune_08" id="26045"/>
          #   </cost>
          #
          # So it shouldn't be an array, but the Cost class should have an
          # attribute that's an array of tokens, maybe.

          # is costs really an array?
          #@costs     = []
          #(elem/:cost).each do |cost|
          # @costs << ItemCost.new(cost)
          #end

          @disenchant_items    = extra_element(elem, :xml => 'disenchantLoot',    :list => 'item',     :class => 'DisenchantItem', :api => api)
          @objective_of_quests = extra_element(elem, :xml => 'objectiveOfQuests', :list => 'quest',    :class => 'ItemQuest')
          @reward_from_quests  = extra_element(elem, :xml => 'rewardFromQuests',  :list => 'quest',    :class => 'ItemQuest')
          @vendors             = extra_element(elem, :xml => 'vendors',           :list => 'creature', :class => 'ItemDropCreature')
          @drop_creatures      = extra_element(elem, :xml => 'dropCreatures',     :list => 'creature', :class => 'ItemDropCreature')
          @plans_for           = extra_element(elem, :xml => 'plansFor',          :list => 'spell',    :class => 'ItemPlansFor', :api => api)

          # Rest of disenchant contents is done in the method above
          if (elem%'disenchantLoot')
            @disenchant_skill_rank = (elem%'disenchantLoot')[:requiredSkillRank].to_i
          end

          # TODO: Handle createdBy and assign it to @created_by
          #
          # Example:
          #
          # 44434:
          #   <createdBy>
          #     <spell icon="trade_engineering" id="60531" name="Create Dark Matter"/>
          #   </createdBy>
        end

        private

        def extra_element(elem, options)
          retval = []

          # Check if the xml element exists
          if (elem%options[:xml])
            # The class that will be instantiated
            klass = Wowr::Classes.const_get(options[:class])

            # Loop through the list elements (e.g., 'disenchantLoot/item'),
            # adding an instance of the specified class to the return value
            (elem%options[:xml]/options[:list]).each do |list|
              if options[:api]
                retval << klass.new(list, options[:api])
              else
                retval << klass.new(list)
              end
            end
          end

          retval
        end
      end
    end
  end
end
