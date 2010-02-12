require 'test_helper'

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
		
		assert_kind_of Integer, dungeon.level_minimum
		assert_kind_of Integer, dungeon.level_maximum
		
		assert_not_nil dungeon.level_minimum
		assert_not_nil dungeon.level_maximum
		
		assert_equal dungeon.level_minimum, dungeon.min_level
		assert_equal dungeon.level_maximum, dungeon.max_level
		
		assert_kind_of Integer, dungeon.party_size
		assert_not_nil dungeon.party_size
		
		# assert_kind_of Boolean, dungeon.raid
		assert_not_nil dungeon.raid
		
		assert_not_nil dungeon.release
		
		# assert_kind_of FalseClass || TrueClass, dungeon.heroic
		assert_not_nil dungeon.heroic
		
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