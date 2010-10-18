require 'spec_helper'

describe Wowr::API, "class accessors" do
  subject { Wowr::API }

  it "should have a version string" do
    subject::VERSION.should_not be_nil
  end

  its(:armory_base_url)          { should eql('wowarmory.com/') }
  its(:search_url)               { should eql('search.xml') }
  its(:character_sheet_url)      { should eql('character-sheet.xml') }
  its(:character_talents_url)    { should eql('character-talents.xml') }
  its(:character_reputation_url) { should eql('character-reputation.xml') }
  its(:guild_info_url)           { should eql('guild-info.xml') }
  its(:item_info_url)            { should eql('item-info.xml') }
  its(:item_tooltip_url)         { should eql('item-tooltip.xml') }
  its(:arena_team_url)           { should eql('team-info.xml') }
  its(:guild_bank_contents_url)  { should eql('vault/guild-bank-contents.xml') }
  its(:guild_bank_log_url)       { should eql('vault/guild-bank-log.xml') }
  its(:login_url)                { should eql('login/login.xml') }
  its(:dungeons_url)             { should eql('_data/dungeons.xml') }
  its(:dungeons_strings_url)     { should eql('data/dungeonStrings.xml') }
  its(:max_connection_tries)     { should eql(10) }
  its(:cache_directory_path)     { should eql('cache/') }
  its(:default_cache_timeout)    { should eql(604800) }
  its(:failed_cache_timeout)     { should eql(86400) }
  its(:cache_failed_requests)    { should be_true }
  its(:calendar_user_url)        { should eql('vault/calendar/month-user.json') }
  its(:calendar_world_url)       { should eql('vault/calendar/month-world.json') }
  its(:calendar_detail_url)      { should eql('vault/calendar/detail.json') }
  its(:persistent_cookie)        { should eql('COM-warcraft') }
  its(:temporary_cookie)         { should eql('JSESSIONID') }
end

describe Wowr::API, "initialization" do
  context "without options" do
    subject { Wowr::API.new }

    its(:locale)        { should eql('us') }
    its(:lang)          { should eql('default') }
    its(:caching)       { should be_true }
    its(:cache_timeout) { should eql(604800) }
    its(:debug)         { should_not be_true }
  end

  context "with options" do
    let(:options) { {:character_name => 'WoW_Toon', :guild_name => 'WoW_Guild', :realm => 'WoW_Realm', :locale => 'uk', :lang => 'English', :caching => false, :cache_timeout => 1600, :debug => true} }
    subject { Wowr::API.new(options) }

    its(:character_name) { should eql(options[:character_name]) }
    its(:guild_name)     { should eql(options[:guild_name]) }
    its(:realm)          { should eql(options[:realm]) }
    its(:locale)         { should eql(options[:locale]) }
    its(:lang)           { should eql(options[:lang]) }
    its(:caching)        { should eql(options[:caching]) }
    its(:cache_timeout)  { should eql(options[:cache_timeout]) }
    its(:debug)          { should eql(options[:debug]) }
  end
end

describe Wowr::API, "attribute accessors" do
  let(:api) { Wowr::API.new(:caching => false) }

  describe "#character_name= and #character_name" do
    it "should assign and return 'ToonName'" do
      api.character_name = 'ToonName'
      api.character_name.should == 'ToonName'
    end
  end

  describe "#guild_name= and #guild_name" do
    it "should assign and return 'GuildName'" do
      api.guild_name = 'GuildName'
      api.guild_name.should == 'GuildName'
    end
  end

  describe "#realm= and #realm" do
    it "should assign and return 'Realm'" do
      api.realm = 'Realm'
      api.realm.should == 'Realm'
    end
  end

  describe "#locale= and #locale" do
    it "should assign and return 'Locale'" do
      api.locale = 'Locale'
      api.locale.should == 'Locale'
    end
  end

  describe "#lang= and #lang" do
    it "should assign and return 'Lang'" do
      api.lang = 'Lang'
      api.lang.should == 'Lang'
    end
  end

  describe "#caching= and #caching" do
    it "should assign and return true" do
      api.caching = true
      api.caching.should == true
    end
  end

  describe "#cache_timeout= and #cache_timeout" do
    it "should assign and return 600" do
      api.cache_timeout = 600
      api.cache_timeout.should == 600
    end
  end

  describe "#debug= and #debug" do
    it "should assign and return true" do
      api.debug = true
      api.debug.should == true
    end
  end
end

describe Wowr::API do
  let(:api) { Wowr::API.new(:caching => false) }

  describe "#search" do
    it "should raise NoSearchString when first param is blank" do
      expect { api.search({}) }.to raise_error(Wowr::Exceptions::NoSearchString)
    end

    it "should raise InvalidSearchType when given an invalid search type" do
      expect { api.search('Foo', :type => 'bar') }.to raise_error(Wowr::Exceptions::InvalidSearchType)
    end
  end

  describe "#search_characters" do
    it { pending }
  end

  describe "#get_character" do
    it "should raise CharacterNotFound when given an invalid character" do
      %w(sheet talents reputation).each do |tab|
        FakeWeb.register_uri(:get, /character-#{tab}\.xml/, :body => file_fixture("armory/character-#{tab}/not_found.xml"))
      end
      expect { api.get_character(:character_name => 'Foo', :realm => 'Bar') }.to raise_error(Wowr::Exceptions::CharacterNotFound)
    end
  end

  describe "#get_character_sheet" do
    it "should call get_character" do
      api.should_receive(:get_character).with('name_argument', {:foo => 'bar'})
      api.get_character_sheet('name_argument', {:foo => 'bar'})
    end
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
    it "should raise GuildNameNotSet when not given a name" do
      expect { api.get_guild({}) }.to raise_error(Wowr::Exceptions::GuildNameNotSet)
    end

    it "should raise RealmNotSet when given a guild name but not a realm" do
      expect { api.get_guild('Foo') }.to raise_error(Wowr::Exceptions::RealmNotSet)
    end

    it "should return an instance of FullGuild when given valid parameters" do
      FakeWeb.register_uri(:get, /guild-info\.xml.*Juggernaut/, :body => file_fixture('armory/guild-info/juggernaut_mal_ganis.xml'))
      api.get_guild(:guild_name => 'Juggernaut', :realm => "Mal'Ganis").should be_kind_of(Wowr::Classes::FullGuild)
    end

    it "should raise GuildNotFound when given an invalid guild" do
      FakeWeb.register_uri(:get, /guild-info\.xml/, :body => file_fixture('armory/guild-info/not_found.xml'))
      expect { api.get_guild('does_not_exist', :realm => 'does_not_exist') }.to raise_error(Wowr::Exceptions::GuildNotFound)
    end
  end

  describe "#search_items" do
    it { pending }
  end

  describe "#get_item" do
    it "should return an instance of FullItem when given valid parameters" do
      FakeWeb.register_uri(:get, /item-info\.xml/,    :body => file_fixture('armory/item-info/40395.xml'))
      FakeWeb.register_uri(:get, /item-tooltip\.xml/, :body => file_fixture('armory/item-tooltip/40395.xml'))
      api.get_item(:item_id => 40395).should be_kind_of(Wowr::Classes::FullItem)
    end

    it "should raise ItemNotFound when given an invalid item number" do
      FakeWeb.register_uri(:get, /item-info\.xml/,    :body => file_fixture('armory/item-info/not_found.xml'))
      FakeWeb.register_uri(:get, /item-tooltip\.xml/, :body => file_fixture('armory/item-tooltip/not_found.xml'))
      expect { api.get_item(0) }.to raise_error(Wowr::Exceptions::ItemNotFound)
    end
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
