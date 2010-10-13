$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'item.rb'
require 'general.rb'

require 'armory/guild_bank/base'
require 'armory/guild_bank/bag'
require 'armory/guild_bank/contents'
require 'armory/guild_bank/log'

module Wowr
  module Classes
    class GuildBank         < Wowr::Armory::GuildBank::Base; end
    class GuildBankContents < Wowr::Armory::GuildBank::Contents; end
    class GuildBankLog      < Wowr::Armory::GuildBank::Log; end
    class GuildBankBag      < Wowr::Armory::GuildBank::Bag; end

    # Zero to 1 items
    # <banklog dtab="" money="1200000" otab="" player="Quixsilver" rank="0" ts="1212595269000" type="4"/>
    # <banklog dtab="" money="0" otab="0" player="Quixsilver" rank="0" ts="1212527470000" type="2">
    #   <item count="1" icon="inv_potion_92" id="12820" name="Winterfall Firewater" qi="1" subtype="" type="consumables"/>
    # </banklog>
    class GuildBankLogEntry
      attr_reader :dtab, :money, :otab, :player, :rank_id, :ts, :type_id, :item, :unknown

      @@types = {
        1 => 'Deposit Item',
        2 => 'Withdraw Item',
        3 => 'Move Item',
        4 => 'Deposit Money',
        5 => 'Withdraw Money',
        6 => 'Repair',
        7 => 'Move Item',
        8 => 'Withdraw Money',
        9 => 'Guild Bank Tab Purchase'
      }

      def initialize(elem, bank = nil, api = nil)
        @bank = bank

        @dtab     = elem[:dtab] == "" ? nil : elem[:dtab].to_i
        @otab     = elem[:otab] == "" ? nil : elem[:otab].to_i
        @money    = Money.new(elem[:money].to_i)
        @player   = elem[:player]
        @unknown  = elem[:unknown] == "1" ? true : false
        @rank_id  = elem[:rank].to_i
        @ts       = elem[:ts].to_i # TODO: Check TS isn't overloading
        @type_id  = elem[:type].to_i

        if (elem%'item')
          @item = GuildBankLogItem.new(elem%'item', api)
        end
      end

      def type
        return @@types[@type_id]
      end

      def rank
        @rank_id.nil? ? nil : @bank.ranks[@rank_id]
      end

      def origin
        @otab.nil? ? nil : @bank.bags[@otab]
      end

      def destination
        @dtab.nil? ? nil : @bank.bags[@dtab]
      end

      def time
        return Time.at(@ts / 1000)
      end
    end

    # Simple item that appears in Wowr::Classes::GuildBankLog entries
    # <item count="1" icon="inv_potion_92" id="12820" name="Winterfall Firewater" qi="1" subtype="" type="consumables"/>
    class GuildBankLogItem < Item
      attr_reader :count, :qi, :subtype, :type

      def initialize(elem, api = nil)
        super(elem, api)
        @count    = elem[:count].to_i
        @qi       = elem[:qi].to_i
        @subtype  = elem[:subtype] == "" ? nil : elem[:subtype]
        @type     = elem[:type]
      end
    end

    # More detailed item used in full Wowr::Classes::GuildBank
    # Very close to Wowr::Classes::EquippedItem
    # <item bag="0" durability="0" icon="racial_dwarf_findtreasure" id="12219" maxDurability="0" name="Unadorned Seal of Ascension" qi="1" quantity="1" randomPropertiesId="0" seed="1827537860" slot="90" subtype="" subtypeLoc="Quest" type="consumables"/>
    class GuildBankItem < Item
      attr_reader :bag_id, :durability, :max_durability, :qi, :quantity,
                  :random_properties_id, :seed, :slot, :subtype, :subtype_loc, :type

      def initialize(elem, bags = nil, api = nil)
        super(elem, api)

        @bag_id   = elem[:bag].to_i
        @qi       = elem[:qi].to_i
        @quantity = elem[:quantity].to_i

        @durability           = elem[:durability].to_i
        @max_durability       = elem[:maxDurability].to_i
        @random_properties_id = elem[:randomPropertiesId] == 0 ? nil : elem[:randomPropertiesId].to_i
        @seed         = elem[:seed].to_i
        @slot         = elem[:slot].to_i
        @subtype      = elem[:subtype]    == "" ? nil : elem[:subtype]
        @subtype_loc  = elem[:subtypeLoc] == "" ? nil : elem[:subtypeLoc]
        @type         = elem[:type].to_i

        bags[@bag_id].items << self
      end
    end
  end
end
