module Wowr
  module Armory
    module Item
      # Represents all of the information found in an Item's tooltip information
      #
      # Noteworthy data available on the info page but not tooltip includes ...
      #
      # == Relevant XML example:
      #
      #   <itemTooltip>
      #     <id>40395</id>
      #     <name>Torch of Holy Fire</name>
      #     <icon>inv_mace_82</icon>
      #     <overallQualityId>4</overallQualityId>
      #     <bonding>1</bonding>
      #     <classId>2</classId>
      #     <equipData>
      #       <inventoryType>21</inventoryType>
      #       <subclassName>Mace</subclassName>
      #     </equipData>
      #     <damageData>
      #       <damage>
      #         <type>0</type>
      #         <min>216</min>
      #         <max>401</max>
      #       </damage>
      #       <speed>1.8</speed>
      #       <dps>85.83</dps>
      #     </damageData>
      #     <bonusStamina>82</bonusStamina>
      #     <bonusSpirit>38</bonusSpirit>
      #     <durability current="105" max="105"/>
      #     <requiredLevel>80</requiredLevel>
      #     <itemLevel>226</itemLevel>
      #     <bonusHasteRating>48</bonusHasteRating>
      #     <bonusSpellPower>651</bonusSpellPower>
      #     <itemSource areaId="3456" areaName="Naxxramas" creatureId="15990" creatureName="Kel'Thuzad" difficulty="h" dropRate="3" value="sourceType.creatureDrop"/>
      #   </itemTooltip>
      #
      # == Example Pages:
      #
      # * http://www.wowarmory.com/item-tooltip.xml?i=16922
      # * http://www.wowarmory.com/item-tooltip.xml?i=40111
      # * http://www.wowarmory.com/item-tooltip.xml?i=40395
      # * http://www.wowarmory.com/item-tooltip.xml?i=46017
      # * http://www.wowarmory.com/item-tooltip.xml?i=50727
      #
      # @todo Explain differences between Tooltip and Info
      class Tooltip < Wowr::Armory::Item::Base
        # Flavor text
        # @example
        #   "The power of creation courses through this weapon."
        # @return [String]
        attr_reader :desc

        # Item quality ID
        # @return [Integer]
        attr_reader :overall_quality_id

        # Item bonding
        # @return [Integer]
        attr_reader :bonding

        # Maximum stack count
        # @return [Integer]
        attr_reader :max_count

        # @return [Integer]
        attr_reader :class_id

        # A hash of <tt>stat => bonus amount</tt> pairs representing stats
        # increased by equipping this item
        # @return [Hash]
        attr_reader :bonuses

        # @return [Source]
        attr_reader :item_source

        attr_reader :resistances

        # @return [Integer]
        attr_reader :required_level

        # An array of allowed classes for class-specific items
        # @return [Array]
        attr_reader :allowable_classes

        # Armor value
        # @note Does not include bonus armor
        # @return [Integer]
        attr_reader :armor

        # @return [Integer]
        attr_reader :durability

        # An array of socket colors on this item; non-unique
        # @example Get the number of blue sockets
        #   tooltip.sockets.count("Blue")
        # @return [Array]
        attr_reader :sockets

        attr_reader :socket_match_enchant

        # Stats granted by equipping a gem
        # @example
        #   "+20 Strength"
        #   "+32 Stamina and 2% Increased Armor Value from Items"
        # @return [String]
        attr_reader :gem_properties

        # Bonuses and effects conferred upon equiping this item
        # @return [EquipData]
        attr_reader :equip_data

        alias_method :description, :desc

        # @param [Hpricot::Elem] elem <tt><itemTooltip></tt> element
        def initialize(elem, api = nil)
          super(elem, api)

          @id                 = (elem%'id').html.to_i
          @name               = (elem%'name').html
          @icon_base          = (elem%'icon').html
          @desc               = (elem/"/desc").text if (elem%'desc')
          @overall_quality_id = (elem%'overallQualityId').html.to_i
          @bonding            = (elem%'bonding').html.to_i
          @stackable          = (elem%'stackable').html.to_i if (elem%'stackable')
          @max_count          = (elem%'maxCount').html.to_i if (elem%'maxCount')
          @class_id           = (elem%'classId').html.to_i
          @required_level     = (elem%'requiredLevel').html.to_i if (elem%'requiredLevel')

          @equip_data         = EquipData.new(elem%'equipData')

          # TODO: This appears to be a plain string at the moment
          #<gemProperties>+26 Healing +9 Spell Damage and 2% Reduced Threat</gemProperties>
          @gem_properties     = (elem%'gemProperties').html if (elem%'gemProperties')

          # not all items have damage data
          @damage             = DamageData.new(elem%'damageData') unless !(elem%'damageData') || (elem%'damageData').empty?

          # TODO: Test socket data with a variety of items
          # TODO: replace with socket Class?
          if (elem%'socketData')
            @sockets = []
            (elem%'socketData'/:socket).each do |socket|
              @sockets << socket[:color]
            end

            @socket_match_enchant = (elem%'socketData'%'socketMatchEnchant')
          end

          # When there is no data, stats are not present in @bonuses
          # TODO: When there is no stats at all, @bonuses shouldn't be set
          @bonuses = {}

          bonus_stats = {
            :strength           => :bonusStrength,
            :agility            => :bonusAgility,
            :stamina            => :bonusStamina,
            :intellect          => :bonusIntellect,
            :spirit             => :bonusSpirit,

            # http://www.wowarmory.com/_layout/items/tooltip.xsl defines these bonuses as well
            :defense            => :bonusDefenseSkillRating,
            :dodge              => :bonusDodgeRating,
            :parry              => :bonusParryRating,
            :block              => :bonusBlockRating,
            :melee_hit          => :bonusHitMeleeRating,
            :ranged_hit         => :bonusHitRangedRating,
            :spell_hit          => :bonusHitSpellRating,
            :melee_crit         => :bonusCritMeleeRating,
            :ranged_crit        => :bonusCritRangedRating,
            :spell_crit         => :bonusCritSpellRating,
            :melee_haste        => :bonusHasteMeleeRating,
            :ranged_haste       => :bonusHasteRangedRating,
            :spell_haste        => :bonusHasteSpellRating,
            :hit                => :bonusHitRating,
            :crit               => :bonusCritRating,
            :resilience         => :bonusResilienceRating,
            :haste              => :bonusHasteRating,
            :spell_power        => :bonusSpellPower,
            :attack_power       => :bonusAttackPower,
            :feral_attack_power => :bonusFeralAttackPower,
            :mana_regen         => :bonusManaRegen,
            :armor_penetration  => :bonusArmorPenetration,
            :block_value        => :bonusBlockValue,
            :health_regen       => :bonusHealthRegen,
            :spell_penetration  => :bonusSpellPenetration,
            :expertise          => :bonusExpertiseRating,
          }
          bonus_stats.each do |stat, xml_elem|
            @bonuses[stat] = test_stat(elem/xml_elem) if test_stat(elem/xml_elem)
          end

          # Resistances
          @resistances = {}

          resist_stats = {
            :arcane => :arcaneResist,
            :fire   => :fireResist,
            :frost  => :frostResist,
            :holy   => :holyResist,
            :nature => :natureResist,
            :shadow => :shadowResist
          }
          resist_stats.each do |stat, xml_elem|
            @resistances[stat] = test_stat(elem/xml_elem) if test_stat(elem/xml_elem)
          end

          if (elem%'allowableClasses')
            @allowable_classes = []
            (elem%'allowableClasses'/:class).each do |klass|
              @allowable_classes << klass.html
            end
          end

          # NOTE not representing armor bonus
          @armor      = (elem%'armor').html.to_i            if (elem%'armor')

          # NOTE not representing max
          @durability = (elem%'durability')[:current].to_i  if (elem%'durability')

          if (elem%'spellData')
            @spells = []
            (elem%'spellData'/:spell).each do |spell|
              @spells << Spell.new(spell)
            end
          end

          # FIXME: Why the random CamelCase all of the sudden? (tsigo)
          @setData = SetData.new(elem%'setData') if (elem%'setData')

          # @item_sources = []
          # (elem/:itemSource).each do |source|
          #   @item_sources << ItemSource.new(source)
          # end
          @item_source = Source.new(elem%'itemSource') if (elem%'itemSource')  # TODO: More than once source?
        end

        private

        def test_stat(elem)
          if elem
            if !elem.html.empty?
              return elem.html.to_i
            end
          end
          return nil
        end
      end
    end
  end
end
