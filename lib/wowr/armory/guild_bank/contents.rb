module Wowr
  module Armory
    module GuildBank
      # bags now contain references to the items
      # Items can be accessed from items (within Wowr::Classes::GuildBankContents)
      # Or by their individual bags using bag.items
      class Contents < Wowr::Armory::GuildBank::Base
        attr_reader :items

        def initialize(elem, api = nil)
          super(elem)
          @money = Money.new((elem%'guildBank')[:money].to_i)

          @items = []
          (elem%'items'/:item).each do |item|
            @items << GuildBankItem.new(item, bags, api)
          end
        end
      end
    end
  end
end
