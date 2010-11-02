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

  def test_money
    no_gold_silver = Wowr::Classes::Money.new(43)
    assert_equal no_gold_silver.gold, 0
    assert_equal no_gold_silver.silver, 0
    assert_equal no_gold_silver.bronze, 43
    assert_equal no_gold_silver.total, 43

    money = Wowr::Classes::Money.new(5552243)
    assert_equal money.gold, 555
    assert_equal money.silver, 22
    assert_equal money.bronze, 43
    assert_equal money.total, 5552243

    assert_equal (money + no_gold_silver).total, 5552286
    assert_equal (money - no_gold_silver).total, 5552200
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
