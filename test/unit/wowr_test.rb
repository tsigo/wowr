require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class WowrTest < Test::Unit::TestCase

  def setup
    @api_empty = Wowr::API.new
    @api_set = Wowr::API.new(:character_name => 'Clublife', :realm => "Barthilas", :guild_name => "Cake")
    @api_no_cache = Wowr::API.new(:caching => false)
  end

  def teardown
    @api_set.clear_cache
    FileUtils.rm_rf(SAVE_PATH)
  end

  def test_assignment
    assert_nothing_raised do
      temp = Wowr::API.search_url
      Wowr::API.search_url = "test"
      Wowr::API.search_url = temp

      temp = Wowr::API.cache_directory_path
      Wowr::API.cache_directory_path = "hello/"
      Wowr::API.cache_directory_path = temp
    end
  end
end
