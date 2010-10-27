require 'benchmark'

require 'rubygems'
require 'fakeweb'
FakeWeb.allow_net_connect = false

$:.unshift(File.expand_path("../lib", __FILE__))
require 'wowr'

module Tests
  module Fixtures
    class << self
      def file_fixture(*args)
        File.read(File.expand_path(File.join("../spec/file_fixtures/", args), __FILE__))
      end

      def register
        # get_character
        %w(sheet talents reputation).each do |v|
          FakeWeb.register_uri(:get, /character-#{v}/, :body => file_fixture("armory/character-#{v}/tsigo_mal_ganis.xml"))
        end

        # get_guild
        FakeWeb.register_uri(:get, /guild-info\.xml.*Juggernaut/, :body => file_fixture('armory/guild-info/juggernaut_mal_ganis.xml'))

        # get_item_info
        FakeWeb.register_uri(:get, /item-info\.xml/, :body => file_fixture('armory/item-info/40395.xml'))

        # get_item_tooltip
        FakeWeb.register_uri(:get, /item-tooltip\.xml/, :body => file_fixture('armory/item-tooltip/40395.xml'))

        # get_arena_team
        FakeWeb.register_uri(:get, /team-info\.xml/, :body => file_fixture('armory/team-info/fav_five_mal_ganis.xml'))

        # Search
        FakeWeb.register_uri(:get, /search\.xml.*searchQuery=Cake/, :body => file_fixture('armory/search/items_cake.xml'))
        FakeWeb.register_uri(:get, /search\.xml.*searchQuery=Juggernaut/, :body => file_fixture('armory/search/guilds_juggernaut.xml'))
        FakeWeb.register_uri(:get, /search\.xml.*searchQuery=Tsigo/, :body => file_fixture('armory/search/characters_tsigo.xml'))
        FakeWeb.register_uri(:get, /search\.xml.*searchQuery=Lemon/, :body => file_fixture('armory/search/arena_teams_lemon.xml'))
      end
    end
  end

  # Tests
  class << self
    def get_character
      Wowr::API.new.get_character("Tsigo", :realm => "Mal'Ganis")
    end

    def get_guild
      Wowr::API.new.get_guild('Juggernaut', :realm => "Mal'Ganis")
    end

    def get_item_info
      Wowr::API.new.get_item_info(40395)
    end

    def get_item_tooltip
      Wowr::API.new.get_item_tooltip(40395)
    end

    def get_arena_team
      Wowr::API.new.get_arena_team('Fav Five', 5, :realm => "Mal'Ganis")
    end

    def search_items
      Wowr::API.new.search_items('Cake')
    end

    def search_guilds
      Wowr::API.new.search_guilds('Juggernaut')
    end

    def search_characters
      Wowr::API.new.search_characters('Tsigo')
    end

    def search_arena_teams
      Wowr::API.new.search_arena_teams('Lemon')
    end
  end
end

Tests::Fixtures.register

n = 1000

puts ''
puts "Running tests #{n} times each..."
puts ''

Benchmark.bm(20) do |b|
  b.report("get_character")      { n.times { Tests.get_character } }
  b.report("get_guild")          { n.times { Tests.get_guild } }
  b.report("get_item_info")      { n.times { Tests.get_item_info } }
  b.report("get_item_tooltip")   { n.times { Tests.get_item_tooltip } }
  b.report("get_arena_team")     { n.times { Tests.get_arena_team } }
  b.report("search_items")       { n.times { Tests.search_items } }
  b.report("search_guilds")      { n.times { Tests.search_guilds } }
  b.report("search_characters")  { n.times { Tests.search_characters } }
  b.report("search_arena_teams") { n.times { Tests.search_arena_teams } }

  # b.report("get_guild_bank_contents")
  # b.report("get_guild_bank_log")
  # b.report("get_complete_world_calendar")
  # b.report("get_world_calendar")
  # b.report("get_full_user_calendar")
  # b.report("get_user_calendar")
  # b.report("get_calendar_event")
  # b.report("get_dungeons")
end
