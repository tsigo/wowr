module Wowr
  module Armory
    module GuildBank
      # Consists of multiple groups, each with 1000 entries
      class Log < Wowr::Armory::GuildBank::Base
        attr_reader :entries, :group_now, :group_next, :group_prev

        def initialize(elem, api = nil)
          super(elem)

          @entries = []

          if (elem%'banklogs')
            (elem%'banklogs'/:banklog).each do |entry|
              @entries << GuildBankLogEntry.new(entry, self, api)
            end

            @group_now = (elem%'banklogs')[:now].to_i
            @group_next = (elem%'banklogs')[:next].to_i
            @group_prev = (elem%'banklogs')[:prev].to_i
          end
        end
      end
    end
  end
end
