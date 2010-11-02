require 'spec_helper'

describe Wowr::API::API, "class accessors" do
  subject { Wowr::API::API }

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

describe Wowr::API::API, "initialization" do
  context "without options" do
    subject { Wowr::API.new }

    its(:lang)          { should eql('en_US') }
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
    its(:lang)           { should eql(options[:lang]) }
    its(:caching)        { should eql(options[:caching]) }
    its(:cache_timeout)  { should eql(options[:cache_timeout]) }
    its(:debug)          { should eql(options[:debug]) }
  end
end

describe Wowr::API::API, "attribute accessors" do
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

describe Wowr::API::API, "search" do
  let(:api) { Wowr::API.new(:caching => false) }

  it "should raise NoSearchString when first param is blank" do
    expect { api.search({}) }.to raise_error(Wowr::Exceptions::NoSearchString)
  end

  it "should raise InvalidSearchType when given an invalid search type" do
    expect { api.search('Foo', :type => 'bar') }.to raise_error(Wowr::Exceptions::InvalidSearchType)
  end

  it "should raise NetworkTimeout when network times out" do
    FakeWeb.register_uri(:get, /searchQuery=NetworkTimeout/, :exception => Timeout::Error)
    expect { api.search('NetworkTimeout', :type => 'items') }.to raise_error(Wowr::Exceptions::NetworkTimeout)
  end

  it "should raise ServerDoesNotExist when given an invalid locale" do
    FakeWeb.register_uri(:get, /searchQuery=InvalidServer/, :exception => SocketError)
    expect { api.search('InvalidServer', :type => 'items') }.to raise_error(Wowr::Exceptions::ServerDoesNotExist)
  end

  describe "#search_items" do
    it "should call #search with the correct parameters" do
      api.expects(:search).with(:search => 'ItemName', :type => 'items').twice
      api.search_items('ItemName')
      api.search_items(:search => 'ItemName')
    end

    it "should return an array of instances of SearchItem" do
      FakeWeb.register_uri(:get, /search\.xml.*searchQuery=Cake/, :body => file_fixture('armory/search/items_cake.xml'))
      results = api.search_items('Cake')
      results.should be_kind_of(Array)
      results[0].should be_kind_of(Wowr::Classes::SearchItem)
    end
  end

  describe "#search_guilds" do
    it "should call #search with the correct parameters" do
      api.expects(:search).with(:search => 'GuildName', :type => 'guilds').twice
      api.search_guilds('GuildName')
      api.search_guilds(:search => 'GuildName')
    end

    it "should return an array of instances of SearchGuild" do
      FakeWeb.register_uri(:get, /search\.xml.*searchQuery=Juggernaut/, :body => file_fixture('armory/search/guilds_juggernaut.xml'))
      results = api.search_guilds('Juggernaut')
      results.should be_kind_of(Array)
      results[0].should be_kind_of(Wowr::Classes::SearchGuild)
    end
  end

  describe "#search_characters" do
    it "should call #search with the correct parameters" do
      api.expects(:search).with(:search => 'CharacterName', :type => 'characters').twice
      api.search_characters('CharacterName')
      api.search_characters(:search => 'CharacterName')
    end

    it "should return an array of instances of SearchCharacter" do
      FakeWeb.register_uri(:get, /search\.xml.*searchQuery=Sebudai/, :body => file_fixture('armory/search/characters_sebudai.xml'))
      results = api.search_characters('Sebudai')
      results.should be_kind_of(Array)
      results[0].should be_kind_of(Wowr::Classes::SearchCharacter)
    end
  end

  describe "#search_arena_teams" do
    it "should call #search with the correct parameters" do
      api.expects(:search).with(:search => 'TeamName', :type => 'arenateams').twice
      api.search_arena_teams('TeamName')
      api.search_arena_teams(:search => 'TeamName')
    end

    it "should return an array of instances of SearchCharacter" do
      FakeWeb.register_uri(:get, /search\.xml.*searchQuery=Lemon/, :body => file_fixture('armory/search/arena_teams_lemon.xml'))
      results = api.search_arena_teams('Lemon')
      results.should be_kind_of(Array)
      results[0].should be_kind_of(Wowr::Classes::SearchArenaTeam)
    end
  end
end

describe Wowr::API::API do
  let(:api) { Wowr::API.new(:caching => false) }

  describe "#get_character" do
    it "should return an instance of FullCharacter when given valid parameters" do
      %w(sheet talents reputation).each do |tab|
        FakeWeb.register_uri(:get, /character-#{tab}\.xml/, :body => file_fixture("armory/character-#{tab}/sebudai_mal_ganis.xml"))
      end
      api.get_character('Sebudai', :realm => "Mal'Ganis").should be_kind_of(Wowr::Classes::FullCharacter)
    end

    it "should raise CharacterNotFound when given an invalid character" do
      %w(sheet talents reputation).each do |tab|
        FakeWeb.register_uri(:get, /character-#{tab}\.xml/, :body => file_fixture("armory/character-#{tab}/not_found.xml"))
      end
      expect { api.get_character(:character_name => 'Foo', :realm => 'Bar') }.to raise_error(Wowr::Exceptions::CharacterNotFound)
    end

    it "should raise CharacterNameNotSet when not given a name" do
      expect { api.get_character(nil, :realm => 'Bar') }.to raise_error(Wowr::Exceptions::CharacterNameNotSet)
    end

    it "should raise RealmNotSet when given a name but not a realm" do
      expect { api.get_character('Foo') }.to raise_error(Wowr::Exceptions::RealmNotSet)
    end
  end

  describe "#get_character_sheet" do
    it "should call get_character" do
      api.expects(:get_character).with('name_argument', {:foo => 'bar'})
      api.get_character_sheet('name_argument', {:foo => 'bar'})
    end
  end

  describe "#get_character_achievements" do
    it "should return an instance of CharacterAchievementsInfo when given valid parameters" do
      FakeWeb.register_uri(:get, /character-achievements\.xml.*Sebudai/, :body => file_fixture('armory/character-achievements/sebudai_mal_ganis.xml'))
      api.get_character_achievements(:character_name => 'Sebudai', :realm => "Mal'Ganis").should be_kind_of(Wowr::Classes::CharacterAchievementsInfo)
    end
  end

  describe "#get_character_achievements_category" do
    it "should return an instance of AchievementsList when given valid parameters" do
      FakeWeb.register_uri(:get, /character-achievements\.xml.*Sebudai/, :body => file_fixture('armory/character-achievements/sebudai_mal_ganis.xml'))
      api.get_character_achievements_category(168, 'Sebudai', :realm => "Mal'Ganis").should be_kind_of(Wowr::Classes::AchievementsList)
    end
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
    it "should return an instance of ItemInfo when given valid parameters" do
      FakeWeb.register_uri(:get, /item-info\.xml/, :body => file_fixture('armory/item-info/40395.xml'))
      api.get_item_info(:item_id => 40395).should be_kind_of(Wowr::Classes::ItemInfo)
    end

    it "should raise ItemNotFound when given an invalid item number" do
      FakeWeb.register_uri(:get, /item-info\.xml/, :body => file_fixture('armory/item-info/not_found.xml'))
      expect { api.get_item_info(0) }.to raise_error(Wowr::Exceptions::ItemNotFound)
    end
  end

  describe "#get_item_tooltip" do
    it "should return an instance of ItemTooltip when given valid parameters" do
      FakeWeb.register_uri(:get, /item-tooltip\.xml/, :body => file_fixture('armory/item-tooltip/40395.xml'))
      api.get_item_tooltip(:item_id => 40395).should be_kind_of(Wowr::Classes::ItemTooltip)
    end

    it "should raise ItemNotFound when given an invalid item number" do
      FakeWeb.register_uri(:get, /item-tooltip\.xml/, :body => file_fixture('armory/item-tooltip/not_found.xml'))
      expect { api.get_item_tooltip(0) }.to raise_error(Wowr::Exceptions::ItemNotFound)
    end
  end

  describe "#get_arena_team" do
    it "should return an instance of ArenaTeam when given valid parameters" do
      FakeWeb.register_uri(:get, /team-info\.xml/, :body => file_fixture('armory/team-info/dont_kill_comfort_ysera.xml'))
      api.get_arena_team('Dont Kill Comfort', 5, :realm => "Ysera").should be_kind_of(Wowr::Classes::ArenaTeam)
    end

    it "should raise ArenaTeamNotFound when given an invalid team name" do
      FakeWeb.register_uri(:get, /team-info\.xml/, :body => file_fixture('armory/team-info/not_found.xml'))
      expect { api.get_arena_team('name', :team_size => 5, :realm => "Mal'Ganis") }.to raise_error(Wowr::Exceptions::ArenaTeamNotFound)
    end

    it "should raise ArenaTeamNameNotSet when not given a team name" do
      expect { api.get_arena_team('', 2) }.to raise_error(Wowr::Exceptions::ArenaTeamNameNotSet)
    end

    it "should raise RealmNotSet when not given a valid realm name" do
      expect { api.get_arena_team(:team_name => 'name', :team_size => 2) }.to raise_error(Wowr::Exceptions::RealmNotSet)
    end

    it "should raise InvalidArenaTeamSize when given an invalid team size" do
      expect { api.get_arena_team('name', 10, :realm => "Mal'Ganis") }.to raise_error(Wowr::Exceptions::InvalidArenaTeamSize)
    end
  end

  # FIXME: I'd love to test the various permutations of ways to pass arguments to this method,
  # but it's broken unless the first parameter is a string. See guild_bank_options in lib/wowr/api/api.rb
  describe "#get_guild_bank_contents" do
    it "should raise CookieNotSet when not given a cookie" do
      pending("get_guild_bank_contents will never raise CookieNotSet")
      # FIXME: This will never pass; see get_guild_bank_contents in lib/wowr/api/api.rb
      # expect { api.get_guild_bank_contents('', :guild_name => 'Juggernaut') }.to raise_error(Wowr::Exceptions::CookieNotSet)
    end

    it "should raise GuildNameNotSet when not given a guild name" do
      expect { api.get_guild_bank_contents('cookie') }.to raise_error(Wowr::Exceptions::GuildNameNotSet)
    end

    it "should raise RealmNotSet when not given a realm name" do
      expect { api.get_guild_bank_contents('cookie', 'Juggernaut') }.to raise_error(Wowr::Exceptions::RealmNotSet)
    end

    it "should raise GuildBankNotFound when given an invalid guild name" do
      pending("Need guild-bank-log/not_found.xml fixture")
      # FakeWeb.register_uri(:get, /guild-bank-contents\.xml/, :body => file_fixture('armory/guild-bank-log/not_found.xml'))
      # expect { api.get_guild_bank_contents('cookie', 'InvalidGuild', :realm => "Mal'Ganis") }.to raise_error(Wowr::Exceptions::GuildBankNotFound)
    end

    it "should return an instance of GuildBankContents when given valid parameters" do
      pending("Fix parameter parsing in get_file")
      # FIXME: Will not pass (tsigo)
      # Failure/Error: api.get_guild_bank_contents('cookie', :guild_name => "Juggernaut", :realm => "Mal'Ganis").should be_kind_of(Wowr::Classes::GuildBankContents)
      # bad URI(is not URI?): https://www.wowarmory.com/vault/guild-bank-contents.xml?gn=cookieJSESSIONID=cookieguild_name{...}realmMal'Ganis&r=Mal%27Ganis
      # FakeWeb.register_uri(:get, /guild-bank-contents\.xml/, :body => file_fixture('armory/guild-bank-log/juggernaut_mal_ganis.xml'))
      # api.get_guild_bank_contents('cookie', :guild_name => "Juggernaut", :realm => "Mal'Ganis").should be_kind_of(Wowr::Classes::GuildBankContents)
    end
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

  describe "#base_url" do
    it "should handle a :secure option" do
      api.base_url(:secure => true).should match(/^https/)
    end

    it "should handle a :login option" do
      api.base_url(:login => true).should match(Wowr::API::API.login_base_url)
    end

    it "should return a default when given no parameters" do
      api.base_url.should match(Wowr::API::API.armory_base_url)
    end
  end
end
