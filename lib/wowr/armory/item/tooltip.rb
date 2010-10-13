module Wowr
  module Armory
    module Item
      # Provides detailed item information
      # Note that the item-tooltip.xml just returns an empty document when the item
      # can't be found.
      class Tooltip < Wowr::Armory::Item::Base
        attr_reader :desc, :overall_quality_id, :bonding, :max_count, #:id, :name, :icon,
          :class_id, :bonuses, :item_source,
          :resistances, :required_level,
          :allowable_classes, :armor, :durability,
          :sockets, :socket_match_enchant,
          :gem_properties, :equip_data
        alias_method :description, :desc

        def initialize(elem, api = nil)
          super(elem, api)
          @id                 = (elem%'id').html.to_i
          @name               = (elem%'name').html
          @icon_base          = (elem%'icon').html
          @desc               = (elem%'desc').html if (elem%'desc')
          @overall_quality_id = (elem%'overallQualityId').html.to_i
          @bonding            = (elem%'bonding').html.to_i
          @stackable          = (elem%'stackable').html.to_i if (elem%'stackable')
          @max_count          = (elem%'maxCount').html.to_i if (elem%'maxCount')
          @class_id           = (elem%'classId').html.to_i
          @required_level     = (elem%'requiredLevel').html.to_i if (elem%'requiredLevel')

          @equip_data         = ItemEquipData.new(elem%'equipData')

          # TODO: This appears to be a plain string at the moment
          #<gemProperties>+26 Healing +9 Spell Damage and 2% Reduced Threat</gemProperties>
          @gem_properties     = (elem%'gemProperties').html if (elem%'gemProperties')

          # not all items have damage data
          @damage             = ItemDamageData.new(elem%'damageData') unless !(elem%'damageData') || (elem%'damageData').empty?


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
            # :bonusHitTakenMeleeRating,
            # :bonusHitTakenRangedRating,
            # :bonusHitTakenSpellRating,
            # :bonusCritTakenMeleeRating,
            # :bonusCritTakenRangedRating,
            # :bonusCritTakenSpellRating,
            :melee_haste        => :bonusHasteMeleeRating,
            :ranged_haste       => :bonusHasteRangedRating,
            :spell_haste        => :bonusHasteSpellRating,
            :hit                => :bonusHitRating,
            :crit               => :bonusCritRating,
            # :bonusHitTakenRating,
            # :bonusCritTakenRating,
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
            :fire => :fireResist,
            :frost => :frostResist,
            :holy => :holyResist,
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
              @spells << ItemSpell.new(spell)
            end

            # Convert specific spell descriptions into bonus values
            regex = {
              :spell_power => /^Increases spell power by ([0-9]+)\.$/,
              :mana_regen  => /^Restores ([0-9]+) mana per 5 sec\.$/,
            }
            @spells.each do |spell|
              regex.each do |bonus, exp|
                if spell.description =~ exp
                  @bonuses[bonus] = spell.description.gsub(exp, '\1').to_i
                end
              end
            end
          end

          @setData = ItemSetData.new(elem%'setData') if (elem%'setData')

          # @item_sources = []
          # (elem/:itemSource).each do |source|
          #   @item_sources << ItemSource.new(source)
          # end
          @item_source = ItemSource.new(elem%'itemSource') if (elem%'itemSource')  # TODO: More than once source?
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
