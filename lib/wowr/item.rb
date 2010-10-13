# TODO: Item sources - Vendors
# sourceType.vendor
# sourceType.questReward
# sourceType.createdBySpell

$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'general.rb'

require 'armory/item/base'
require 'armory/item/created'
require 'armory/item/disenchant'
require 'armory/item/full'
require 'armory/item/info'
require 'armory/item/plan'
require 'armory/item/reagent'
require 'armory/item/search'
require 'armory/item/tooltip'

module Wowr
  module Classes
    class Item           < Wowr::Armory::Item::Base; end
    class FullItem       < Wowr::Armory::Item::Full; end
    class ItemInfo       < Wowr::Armory::Item::Info; end
    class ItemTooltip    < Wowr::Armory::Item::Tooltip; end
    class SearchItem     < Wowr::Armory::Item::Search; end
    class DisenchantItem < Wowr::Armory::Item::Disenchant; end
    class CreatedItem    < Wowr::Armory::Item::Created; end
    class PlanItem       < Wowr::Armory::Item::Plan; end
    class Reagent        < Wowr::Armory::Item::Reagent; end

    class ItemEquipData
      attr_reader :inventory_type, :subclass_name, :container_slots

      def initialize(elem)
        @inventory_type = (elem%'inventoryType').html.to_i
        @subclass_name = (elem%'subclassName').html if (elem%'subclassName')
        @container_slots = (elem%'containerSlots').html.to_i if (elem%'containerSlots') # for baggies
      end
    end

    class ItemSetData
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

    class ItemSetBonus
      attr_reader :threshold, :description
      alias_method :desc, :description
      alias_method :to_s, :description

      def initialize(elem)
        @threshold = elem[:threshold].to_i
        @description = elem[:desc]
      end
    end

    class ItemSpell
      attr_reader :trigger, :description
      alias_method :desc, :description
      alias_method :to_s, :description

      def initialize(elem)
        @trigger = (elem%'trigger').html.to_i
        @description = (elem%'desc').html
      end
    end

    class ItemDamageData
      attr_reader :type, :min, :max, :speed, :dps

      def initialize(elem)
        @type   = (elem%'damage'%'type').html.to_i
        @min    = (elem%'damage'%'min').html.to_i
        @max    = (elem%'damage'%'max').html.to_i
        @speed  = (elem%'speed').html.to_f  if (elem%'speed')
        @dps    = (elem%'dps').html.to_f    if (elem%'dps')
      end
    end

    class ItemSource
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

    # <rewardFromQuests>
    #   <quest name="Justice Dispensed" level="39" reqMinLevel="30" id="11206" area="Dustwallow Marsh" suggestedPartySize="0"></quest>
    #   <quest name="Peace at Last" level="39" reqMinLevel="30" id="11152" area="Dustwallow Marsh" suggestedPartySize="0"></quest>
    # </rewardFromQuests>
    # TODO: Rename
    class ItemQuest
      attr_reader :name, :id, :level, :min_level, :area, :suggested_party_size

      def initialize(elem)
        @name       = elem[:name]
        @id         = elem[:id].to_i
        @level      = elem[:level].to_i
        @min_level  = elem[:min_level].to_i
        @area       = elem[:area]
        @suggested_party_size = elem[:suggested_party_size].to_i
      end
    end

    # Creatures that drop the item
    # <creature name="Giant Marsh Frog" minLevel="1" type="Critter" maxLevel="1" dropRate="6" id="23979" classification="0" area="Dustwallow Marsh"></creature>
    # <creature name="Nalorakk" minLevel="73" title="Bear Avatar" url="fl[source]=dungeon&amp;fl[difficulty]=normal&amp;fl[boss]=23576" type="Humanoid" maxLevel="73" dropRate="2" id="23576" classification="3" areaUrl="fl[source]=dungeon&amp;fl[boss]=all&amp;fl[difficulty]=normal&amp;fl[dungeon]=3805" area="Zul'Aman"></creature>
    class ItemDropCreature
      attr_reader :name, :id, :type, :min_level, :max_level, :drop_rate, :classification, :area

      def initialize(elem)
        @name           = elem[:name]
        @id             = elem[:id].to_i
        @min_level      = elem[:minLevel].to_i
        @max_level      = elem[:maxLevel].to_i
        @drop_rate      = elem[:dropRate].to_i
        @classification = elem[:classification].to_i
        @area           = elem[:area]

        # optional boss stuff
        @title    = elem[:title]    if elem[:title] # TODO: not nil when no property?
        @url      = elem[:url]      if elem[:url]
        @type     = elem[:type]     if elem[:type] # Humanoid etc.
        @area_url = elem[:areaUrl]  if elem[:areaUrl]
      end
    end

    # Cost can be gold or a set of required tokens
    # See ItemCostToken
    # <cost sellPrice="280" buyPrice="5600"></cost>
    # <cost>
    #   <token icon="spell_holy_championsbond" id="29434" count="60"></token>
    # </cost>
    class ItemCost
      attr_reader :buy_price, :sell_price, :tokens, :honor_price, :arena_price

      def initialize(elem)
        @honor_price = Money.new(elem[:honor].to_i) if elem[:honor]
        @arena_price = Money.new(elem[:arena].to_i) if elem[:arena]
        @buy_price  = Money.new(elem[:buyPrice].to_i) if elem[:buyPrice]
        @sell_price = Money.new(elem[:sellPrice].to_i)  if elem[:sellPrice]

        if (elem%'token')
          @tokens = []
          (elem/:token).each do |token|
            @tokens << ItemCostToken.new(token)
          end
        end
      end
    end

    # <token icon="spell_holy_championsbond" id="29434" count="60"></token>
    class ItemCostToken < Item
      attr_reader :count

      def initialize(elem, api = nil)
        super(elem)
        # @id = elem[:id].to_i
        # @icon_bse = elem[:icon]
        @count = elem[:count].to_i
      end
    end

    class ItemVendor
      attr_reader :id, :name, :title, :type,
                  :area, :classification, :max_level, :min_level
      alias_method :to_s, :name
      alias_method :to_i, :id

      def initialize(elem)
        @id             = elem[:id].to_i
        @name           = elem[:name]
        @title          = elem[:title]
        @type           = elem[:type]
        @area           = elem[:area]
        @classification = elem[:classification].to_i
        @max_level      = elem[:maxLevel].to_i
        @min_level      = elem[:minLevel].to_i
      end
    end

    # TODO rename
    # There is some sort of opposite relationship between PlansFor and CreatedBy
    class ItemCreation < Item
      attr_reader :item, :reagents

      def initialize(elem, api = nil)
        super(elem, api)

        if (elem%'reagent')
          @reagents = []
          (elem/:reagent).each do |reagent|
            @reagents << Reagent.new(reagent, api)
          end
        end
      end
    end

    # (fold)
    # <plansFor>
    #   <spell name="Shadowprowler's Chestguard" icon="trade_leatherworking" id="42731">
    #     <item name="Shadowprowler's Chestguard" icon="inv_chest_plate11" type="Leather" level="105" id="33204" quality="4"></item>
    #     <reagent name="Heavy Knothide Leather" icon="inv_misc_leatherscrap_11" id="23793" count="10"></reagent>
    #   </spell>
    # </plansFor>
    # (end)
    class ItemPlansFor < ItemCreation
      def initialize(elem, api = nil)
        super(elem, api)
        # TODO: Multiple items?
        @item = CreatedItem.new(elem%'item')  if (elem%'item')
      end
    end

    # <createdBy>
    #   <spell name="Bracing Earthstorm Diamond" icon="temp" id="32867">
    #     <item requiredSkill="Jewelcrafting" name="Design: Bracing Earthstorm Diamond" icon="inv_scroll_03" type="Jewelcrafting" level="73" id="25903" requiredSkillRank="365" quality="1"></item>
    #     <reagent name="Earthstorm Diamond" icon="inv_misc_gem_diamond_04" id="25867" count="1"></reagent>
    #   </spell>
    # </createdBy>
    class ItemCreatedBy < ItemCreation
      def initialize(elem, api = nil)
        super(elem, api)
        # TODO: Multiple items?
        @item = PlanItem.new(elem%'item') if (elem%'item')
      end
    end
  end
end
