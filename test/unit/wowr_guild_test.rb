require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class WowrGuildTest < Test::Unit::TestCase
  def setup
    @api_empty = Wowr::API.new
    @api_set = Wowr::API.new(:character_name => 'Clublife', :realm => "Barthilas", :guild_name => "Cake")
  end

  def teardown
    @api_set.clear_cache
  end

  def test_guild
    assert_instance_of Wowr::Classes::SearchGuild, @api_empty.search_guilds("Moo").first
  end
end
