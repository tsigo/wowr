module Wowr
  module Armory
    module GuildBank
      class Base < Wowr::Armory::Guild::Base
        attr_reader :motd, :info, :money, :ranks, :bags

        def initialize(elem)
          super(elem%'guildHeader')

          @motd = (elem%'guildMessages')[:motd]
          @info = (elem%'guildMessages')[:info]
          @info.gsub("&#10;", "\n")

            @bags = []
          (elem%'bags'/:bag).each do |bag|
            @bags[bag[:id].to_i] = Bag.new(bag)
          end

          @ranks = []
          (elem%'guildRanks'/:rank).each do |rank|
            @ranks[rank[:id].to_i] = rank[:name]
          end
        end
      end
    end
  end
end
