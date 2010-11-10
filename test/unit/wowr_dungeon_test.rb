require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class WowrDungeonTest < Test::Unit::TestCase
  def setup
    @api_no_cache = Wowr::API.new(:caching => false)
  end

  def test_dungeons
    dungeons = @api_no_cache.get_dungeons

    assert_equal dungeons["botanica"], dungeons[3847]

    dungeons.values.uniq.each do |dungeon|
      test_dungeon(dungeon)
    end
  end

  def test_dungeon(dungeon)
    # at least one should be set
    if (!dungeon.key)
      assert_not_nil dungeon.id
    else
      assert_not_nil dungeon.key
    end

    assert_equal dungeon.bosses["commandersarannis"], dungeon.bosses[3847]
    assert_equal dungeon.bosses["highbotanistfreywinn"], dungeon.bosses[17975]

    dungeon.bosses.values.uniq.each do |boss|
      test_boss(boss)
    end
  end

  def test_boss(boss)
    if (!boss.key)
      assert_not_nil boss.id
    else
      assert_not_nil boss.key
    end
    assert_not_nil boss.type
  end

end
