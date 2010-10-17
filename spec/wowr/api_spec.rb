require 'spec_helper'

describe Wowr::API do
  context "Class" do
    before :each do
      @class = Wowr::API
    end

    #
    # Constants and Class Methods
    #
    describe "VERSION" do
      it "should return '0.4.1'" do
        @class::VERSION.should == '0.4.1'
      end
    end

    describe "#armory_base_url" do
      it "should return a string of 'wowarmory.com/'" do
        @class.armory_base_url.should == 'wowarmory.com/'
      end
    end

    describe "#search_url" do
      it "should return a string of 'search.xml'" do
        @class.search_url.should == 'search.xml'
      end
    end

    describe "#character_sheet_url" do
      it "should return a string of 'character-sheet.xml'" do
        @class.character_sheet_url.should == 'character-sheet.xml'
      end
    end

    describe "#character_talents_url" do
      it "should return a string of 'character-talents.xml'" do
        @class.character_talents_url.should == 'character-talents.xml'
      end
    end

    describe "#character_reputation_url" do
      it "should return a string of 'character-reputation.xml'" do
        @class.character_reputation_url.should == 'character-reputation.xml'
      end
    end

    describe "#guild_info_url" do
      it "should return a string of 'guild-info.xml'" do
        @class.guild_info_url.should == 'guild-info.xml'
      end
    end

    describe "#item_info_url" do
      it "should return a string of 'item-info.xml'" do
        @class.item_info_url.should == 'item-info.xml'
      end
    end

    describe "#item_tooltip_url" do
      it "should return a string of 'item-tooltip.xml'" do
        @class.item_tooltip_url.should == 'item-tooltip.xml'
      end
    end

    describe "#arena_team_url" do
      it "should return a string of 'team-info.xml'" do
        @class.arena_team_url.should == 'team-info.xml'
      end
    end

    describe "#guild_bank_contents_url" do
      it "should return a string of 'vault/guild-bank-contents.xml'" do
        @class.guild_bank_contents_url.should == 'vault/guild-bank-contents.xml'
      end
    end

    describe "#guild_bank_log_url" do
      it "should return a string of 'vault/guild-bank-log.xml'" do
        @class.guild_bank_log_url.should == 'vault/guild-bank-log.xml'
      end
    end

    describe "#login_url" do
      it "should return a string of 'login/login.xml'" do
        @class.login_url.should == 'login/login.xml'
      end
    end

    describe "#dungeons_url" do
      it "should return a string of '_data/dungeons.xml'" do
        @class.dungeons_url.should == '_data/dungeons.xml'
      end
    end

    describe "#dungeons_strings_url" do
      it "should return a string of 'data/dungeonStrings.xml'" do
        @class.dungeons_strings_url.should == 'data/dungeonStrings.xml'
      end
    end

    describe "#max_connection_tries" do
      it "should return 10" do
        @class.max_connection_tries.should == 10
      end
    end

    describe "#cache_directory_path" do
      it "should return a string of 'cache/'" do
        @class.cache_directory_path.should == 'cache/'
      end
    end

    describe "#default_cache_timeout" do
      it "should return 604800" do
        @class.default_cache_timeout.should == 604800
      end
    end

    describe "#failed_cache_timeout" do
      it "should return 86400" do
        @class.failed_cache_timeout.should == 86400
      end
    end

    describe "#cache_failed_requests" do
      it "should return true" do
        @class.cache_failed_requests.should == true
      end
    end

    describe "#calendar_user_url" do
      it "should return a string of 'vault/calendar/month-user.json'" do
        @class.calendar_user_url.should == 'vault/calendar/month-user.json'
      end
    end

    describe "#calendar_world_url" do
      it "should return string of 'vault/calendar/month-world.json'" do
        @class.calendar_world_url.should == 'vault/calendar/month-world.json'
      end
    end

    describe "#calendar_detail_url" do
      it "should return a string of 'vault/calendar/detail.json'" do
        @class.calendar_detail_url.should == 'vault/calendar/detail.json'
      end
    end

    describe "#persistant_cookie" do
      it "should return a string of 'COM-warcraft'" do
        @class.persistant_cookie.should == 'COM-warcraft'
      end
    end

    describe "#temporary_cookie" do
      it "should return a string of 'JSESSIONID'" do
        @class.temporary_cookie.should == 'JSESSIONID'
      end
    end
  end

  describe "initialization" do
    context "with no options" do
      before :each do
        @api = Wowr::API.new
      end

      describe "#locale" do
        it "should default to 'us'" do
          @api.locale.should == 'us'
        end
      end

      describe "#lang" do
        it "should default to 'default'" do
          @api.lang.should == 'default'
        end
      end

      describe "#caching" do
        it "should default to true" do
          @api.caching.should == true
        end
      end

      describe "#cache_timeout" do
        it "should default to 604800" do
          @api.cache_timeout.should == 604800
        end
      end

      describe "#debug" do
        it "should default to false" do
          @api.debug.should == false
        end
      end
    end

    context "with options" do
      before :each do
        @options = { :character_name => 'WoW_Toon', :guild_name => 'WoW_Guild', :realm => 'WoW_Realm', :locale => 'uk', :lang => 'English', :caching => false, :cache_timeout => 1600, :debug => true }
        @api = Wowr::API.new(@options)
      end

      describe "#character_name" do
        it "should return value of options[:character_name]" do
          @api.character_name.should == @options[:character_name]
        end
      end

      describe "#guild_name" do
        it "should return value of options[:guild]" do
          @api.guild_name.should == @options[:guild_name]
        end
      end

      describe "#realm" do
        it "should return value of options[:realm]" do
          @api.realm.should == @options[:realm]
        end
      end

      describe "#locale" do
        it "should return value of options[:locale]" do
          @api.locale.should == @options[:locale]
        end
      end

      describe "#lang" do
        it "should return value of options[:lang]" do
          @api.lang.should == @options[:lang]
        end
      end

      describe "#caching" do
        it "should return value of options[:caching]" do
          @api.caching.should == @options[:caching]
        end
      end

      describe "#cache_timeout" do
        it "should return value of options[:cache_timeout]" do
          @api.cache_timeout.should == @options[:cache_timeout]
        end
      end

      describe "#debug" do
        it "should return value of options[:debug]" do
          @api.debug.should == @options[:debug]
        end
      end
    end
  end

  describe "instance" do
    before :each do
      @api = Wowr::API.new
    end

    #
    # Attribute Accessor Methods
    #
    describe "#character_name= and #character_name" do
      it "should assign and return 'ToonName'" do
        @api.character_name = 'ToonName'
        @api.character_name.should == 'ToonName'
      end
    end

    describe "#guild_name= and #guild_name" do
      it "should assign and return 'GuildName'" do
        @api.guild_name = 'GuildName'
        @api.guild_name.should == 'GuildName'
      end
    end

    describe "#realm= and #realm" do
      it "should assign and return 'Realm'" do
        @api.realm = 'Realm'
        @api.realm.should == 'Realm'
      end
    end

    describe "#locale= and #locale" do
      it "should assign and return 'Locale'" do
        @api.locale = 'Locale'
        @api.locale.should == 'Locale'
      end
    end

    describe "#lang= and #lang" do
      it "should assign and return 'Lang'" do
        @api.lang = 'Lang'
        @api.lang.should == 'Lang'
      end
    end

    describe "#caching= and #caching" do
      it "should assign and return true" do
        @api.caching = true
        @api.caching.should == true
      end
    end

    describe "#cache_timeout= and #cache_timeout" do
      it "should assign and return 600" do
        @api.cache_timeout = 600
        @api.cache_timeout.should == 600
      end
    end

    describe "#debug= and #debug" do
      it "should assign and return true" do
        @api.debug = true
        @api.debug.should == true
      end
    end

    #
    # Public Methods (WoW Armory API Calls)
    #
    describe "#search" do
      it { pending }
    end

    describe "#search_characters" do
      it { pending }
    end

    describe "#get_character" do
      it { pending }
    end

    describe "#get_character_sheet" do
      it { pending }
    end

    describe "#get_character_achievements" do
      it { pending }
    end

    describe "#get_character_achievements_category" do
      it { pending }
    end

    describe "#search_guilds" do
      it { pending }
    end

    describe "#get_guild" do
      it "should raise GuildNotFound when given an invalid guild" do
        FakeWeb.register_uri(:get, /guild-info\.xml/, :body => file_fixture('armory/guild-info/not_found.xml'))
        expect { @api.get_guild('does_not_exist', :realm => 'does_not_exist') }.to raise_error(Wowr::Exceptions::GuildNotFound)
      end
    end

    describe "#search_items" do
      it { pending }
    end

    describe "#get_item" do
      it { pending }
    end

    describe "#get_item_info" do
      it { pending }
    end

    describe "#get_item_tooltip" do
      it { pending }
    end

    describe "#search_arena_teams" do
      it { pending }
    end

    describe "#get_arena_team" do
      it { pending }
    end

    describe "#get_guild_bank_contents" do
      it { pending }
    end

    describe "#get_guild_bank_log" do
      it { pending }
    end

    describe "#get_complete_world_calendar" do
      it { pending }
    end

    describe "#get_world_calendar" do
      it { pending }
    end

    describe "#get_full_user_calendar" do
      it { pending }
    end

    describe "#get_user_calendar" do
      it { pending }
    end

    describe "#get_calendar_event" do
      it { pending }
    end

    describe "#get_dungeons" do
      it { pending }
    end

    describe "#login" do
      it { pending }
    end

    describe "#refresh_login" do
      it { pending }
    end

    describe "#clear_cache" do
      it { pending }
    end

    describe "#base_url" do
      it { pending }
    end
  end
end
