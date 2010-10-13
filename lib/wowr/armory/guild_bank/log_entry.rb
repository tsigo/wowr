module Wowr
  module Armory
    module GuildBank
      # Zero to 1 items
      # <banklog dtab="" money="1200000" otab="" player="Quixsilver" rank="0" ts="1212595269000" type="4"/>
      # <banklog dtab="" money="0" otab="0" player="Quixsilver" rank="0" ts="1212527470000" type="2">
      #   <item count="1" icon="inv_potion_92" id="12820" name="Winterfall Firewater" qi="1" subtype="" type="consumables"/>
      # </banklog>
      class LogEntry
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
    end
  end
end
