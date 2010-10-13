module Wowr
  module Armory
    module GuildBank
    # Simple item that appears in Wowr::Classes::GuildBankLog entries
    # <item count="1" icon="inv_potion_92" id="12820" name="Winterfall Firewater" qi="1" subtype="" type="consumables"/>
    class LogItem < Wowr::Armory::Item::Base
      attr_reader :count, :qi, :subtype, :type

      def initialize(elem, api = nil)
        super(elem, api)
        @count    = elem[:count].to_i
        @qi       = elem[:qi].to_i
        @subtype  = elem[:subtype] == "" ? nil : elem[:subtype]
        @type     = elem[:type]
      end
    end
    end
  end
end
