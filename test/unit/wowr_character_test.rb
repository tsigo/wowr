require File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_helper'))

class WowrCharacterTest < Test::Unit::TestCase
  def setup
    @api_set = Wowr::API.new(:character_name => 'Clublife', :realm => "Barthilas", :guild_name => "Cake")
  end

  def teardown
    @api_set.clear_cache
  end

  context "A Wowr::Classes::FullCharacter instance given example character sheet and reputation XML" do
    setup do
      api = Wowr::API.new
      @character_sheet = api.send(:parser, example_character_sheet_xml)
      @character_reputation = api.send(:parser, example_character_reputation_xml)
      @character_talents = api.send(:parser, example_character_talents_xml)
      @character = Wowr::Classes::FullCharacter.new(@character_sheet, @character_reputation, @character_talents)
    end

    # assert class is FullCharacter

    ###
    # Wowr::Classes::Character methods
    # should(name, options = {}, &blk)
    should "return a name when sent :name" do assert_equal("Wimnock", @character.name) end
    should "return a level when sent :level" do assert_equal(80, @character.level) end
    should "return a url when sent :url" do assert_equal("r=Spirestone&cn=Wimnock", @character.url) end
    should "return a rank when sent :rank" do assert_equal(0, @character.rank) end # TODO: remove? doesn't seem to be returned in xml
    should "return a class when sent :klass" do assert_equal("Warlock", @character.klass) end
    should "return a class id when sent :klass_id" do assert_equal(9, @character.klass_id) end
    should "return a gender when sent :gender" do assert_equal("Male", @character.gender) end
    should "return a gender id when sent :gender_id" do assert_equal(0, @character.gender_id) end
    should "return a race when sent :race" do assert_equal("Gnome", @character.race) end
    should "return a race id when sent :race_id" do assert_equal(7, @character.race_id) end
    should "return a faction when sent :faction" do assert_equal("Alliance", @character.faction) end
    should "return a faction id when sent :faction_id" do assert_equal(0, @character.faction_id) end
    should "return realm when sent :realm" do assert_equal("Spirestone", @character.realm) end
    should "return battle group when sent :battle_group" do assert_equal("Reckoning", @character.battle_group) end
    should "return relevance when sent :relevance" do assert_equal(0, @character.relevance) end # TODO: remove? doesn't seem to be returned in xml
    should "return search rank when sent :search_rank" do assert_equal(0, @character.search_rank) end # TODO: remove? doesn't seem to be returned in xml
    should "return achievement points when sent :achievement_points" do assert_equal(1865, @character.achievement_points) end
    should "return last login when sent :last_login" do assert_equal(nil, @character.last_login) end  # TODO: remove? doesn't seem to be returned in xml

    context "given a replacement with mock data for elem" do
      setup do
        @guilded_character = Wowr::Classes::FullCharacter.new({:guild => "ThanksForAllTheFish", :guild_id => "42", :guild_url => "/thank-you-for-all-the-fish"}, @character_reputation)
        # @soloed_character =
      end

      # assert class is Character

      ###
      # Wowr::Classes::Character methods
    end
    # If these are empty they should return nil, create two mock @characters?
    # should "return guild or nil when sent :guild", { }
    # should "return guild id or nil when sent :guild_id", { }
    # should "return guild url or nil when sent :guild_url", { }
    # should "return prefix or nil when sent :prefix", { }
    # should "retun suffix or nil when sent :suffix", { }

    ###
    # Wowr::Classes::CharacterInfo
    # should "return last modified date when sent :last_modified", { }
    # should "return a url when sent :char_url" do assert_equal("r=Spirestone&cn=Wimnock", @character.char_url) end
  end

=begin
  def test_character_contents

    # Reve::API.cakes = XML_BASE + '.xml'
    character = nil
    assert_nothing_raised do
      character = @api_set.get_character
    end

    assert_instance_of Wowr::Classes::FullCharacter, character

    # assert_not_nil character.last_modified

    assert_instance_of Wowr::Classes::Agility, character.agi
    assert_instance_of Wowr::Classes::Agility, character.agility

    # assert_equals character.agi.base, character.agility.base
    # assert_equals character.agi.armor, character.agility.armor

    character.arena_teams do |arena_team|



    end
  end

  def test_character_exceptions
    no_data_api = Wowr::API.new
    only_realm_api = Wowr::API.new(:realm => "Stormrage")
    defaults_api = Wowr::API.new(:character_name => "cake", :realm => "Barthilas")

    assert_raises Wowr::Exceptions::CharacterNameNotSet do
      no_data_api.get_character
    end

    assert_raises Wowr::Exceptions::CharacterNameNotSet do
      only_realm_api.get_character
    end

    assert_raises Wowr::Exceptions::RealmNotSet do
      no_data_api.get_character("Phog")
    end

    assert_nothing_raised do
      defaults_api.get_character
      only_realm_api.get_character("Phog")
    end

    assert_nothing_raised do
      defaults_api.get_character_sheet
      only_realm_api.get_character_sheet("Phog")
    end

  end
=end

  private

  def example_character_sheet_xml
    <<-XML
    <?xml version="1.0" encoding="UTF-8"?><?xml-stylesheet type="text/xsl" href="/_layout/character/sheet.xsl"?>
    <page globalSearch="1" lang="en_us" requestUrl="/character-sheet.xml">
      <tabInfo subTab="profile" tab="character" tabGroup="character" tabUrl="r=Spirestone&amp;cn=Wimnock"/>
      <characterInfo>
        <character battleGroup="Reckoning" charUrl="r=Spirestone&amp;cn=Wimnock" class="Warlock" classId="9" classUrl="c=Warlock" faction="Alliance" factionId="0" gender="Male" genderId="0" guildName="" lastModified="February 16, 2010" level="80" name="Wimnock" points="1865" prefix="" race="Gnome" raceId="7" realm="Spirestone" suffix=" the Patient" titleId="137">
          <modelBasePath value="http://us.media.battle.net.edgesuite.net/"/>
        </character>
        <characterTab>
          <talentSpecs>
            <talentSpec group="2" icon="spell_shadow_deathcoil" prim="Affliction" treeOne="52" treeThree="8" treeTwo="11"/>
            <talentSpec active="1" group="1" icon="spell_shadow_metamorphosis" prim="Demonology" treeOne="0" treeThree="31" treeTwo="40"/>
          </talentSpecs>
          <buffs/>
          <debuffs/>
          <pvp>
            <lifetimehonorablekills value="1367"/>
            <arenacurrency value="0"/>
          </pvp>
          <professions>
            <skill id="755" key="jewelcrafting" max="450" name="Jewelcrafting" value="450"/>
            <skill id="186" key="mining" max="450" name="Mining" value="450"/>
          </professions>
          <characterBars>
            <health effective="20666"/>
            <secondBar casting="61" effective="24185" notCasting="315" type="m"/>
          </characterBars>
          <baseStats>
            <strength attack="64" base="54" block="-1" effective="74"/>
            <agility armor="178" attack="-1" base="69" critHitPercent="4.38" effective="89"/>
            <stamina base="163" effective="1308" health="12900" petBonus="392"/>
            <intellect base="170" critHitPercent="9.66" effective="1327" mana="19625" petBonus="398"/>
            <spirit base="166" effective="417" healthRegen="23" manaRegen="254"/>
            <armor base="2183" effective="2183" percent="12.53" petBonus="764"/>
          </baseStats>
          <resistances>
            <arcane petBonus="0" value="0"/>
            <fire petBonus="0" value="0"/>
            <frost petBonus="0" value="0"/>
            <holy petBonus="0" value="0"/>
            <nature petBonus="0" value="0"/>
            <shadow petBonus="0" value="0"/>
          </resistances>
          <melee>
            <mainHandDamage dps="128.8" max="300" min="105" percent="0" speed="1.57"/>
            <offHandDamage dps="0.0" max="0" min="0" percent="0" speed="1.75"/>
            <mainHandSpeed hastePercent="14.55" hasteRating="477" value="1.57"/>
            <offHandSpeed hastePercent="14.55" hasteRating="477" value="1.75"/>
            <power base="128" effective="128" increasedDps="9.0"/>
            <hitRating increasedHitPercent="11.10" penetration="0" reducedArmorPercent="0.00" value="364"/>
            <critChance percent="4.93" plusPercent="10.06" rating="462"/>
            <expertise additional="0" percent="0.00" rating="0" value="0"/>
          </melee>
          <ranged>
            <weaponSkill rating="0" value="0"/>
            <damage dps="414.1" max="846" min="455" percent="0" speed="1.57"/>
            <speed hastePercent="14.55" hasteRating="477" value="1.57"/>
            <power base="79" effective="79" increasedDps="5.0" petAttack="-1.00" petSpell="-1.00"/>
            <hitRating increasedHitPercent="11.10" penetration="0" reducedArmorPercent="0.00" value="364"/>
            <critChance percent="18.45" plusPercent="10.06" rating="462"/>
          </ranged>
          <spell>
            <bonusDamage>
              <arcane value="2105"/>
              <fire value="2105"/>
              <frost value="2105"/>
              <holy value="2105"/>
              <nature value="2105"/>
              <shadow value="2105"/>
              <petBonus attack="1200" damage="316" fromType="fire"/>
            </bonusDamage>
            <bonusHealing value="2105"/>
            <hitRating increasedHitPercent="13.88" penetration="25" reducedResist="25" value="364"/>
            <critChance rating="462">
              <arcane percent="24.73"/>
              <fire percent="29.73"/>
              <frost percent="24.73"/>
              <holy percent="24.73"/>
              <nature percent="24.73"/>
              <shadow percent="24.73"/>
            </critChance>
            <penetration value="25"/>
            <manaRegen casting="61.00" notCasting="315.00"/>
            <hasteRating hastePercent="14.55" hasteRating="477"/>
          </spell>
          <defenses>
            <armor base="2183" effective="2183" percent="12.53" petBonus="764"/>
            <defense decreasePercent="0.00" increasePercent="0.00" plusDefense="0" rating="0" value="400.00"/>
            <dodge increasePercent="0.00" percent="3.91" rating="0"/>
            <parry increasePercent="0.00" percent="0.00" rating="0"/>
            <block increasePercent="0.00" percent="0.00" rating="0"/>
            <resilience damagePercent="1.33" hitPercent="0.60" value="57.00"/>
          </defenses>
          <items>
            <item displayInfoId="61162" durability="40" gem0Id="41401" gem1Id="49110" gem2Id="0" gemIcon0="inv_jewelcrafting_shadowspirit_02" gemIcon1="inv_misc_gem_pearl_12" icon="inv_helmet_146" id="47693" level="245" maxDurability="60" name="Hood of Fiery Aftermath" permanentEnchantIcon="ability_warrior_shieldmastery" permanentEnchantItemId="44152" permanentenchant="3819" pickUp="PickUpCloth_Leather01" putDown="PutDownCloth_Leather01" randomPropertiesId="0" rarity="4" seed="0" slot="0"/>
            <item displayInfoId="39162" durability="0" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_jewelry_necklace_36" id="42038" level="226" maxDurability="0" name="Furious Gladiator's Pendant of Subjugation" permanentenchant="0" pickUp="PickUpRing" putDown="PutDownRing" randomPropertiesId="0" rarity="4" seed="0" slot="1"/>
            <item displayInfoId="61172" durability="42" gem0Id="40122" gem1Id="0" gem2Id="0" gemIcon0="inv_jewelcrafting_gem_42" icon="inv_shoulder_110" id="47715" level="245" maxDurability="60" name="Pauldrons of Revered Mortality" permanentEnchantIcon="spell_holy_powerinfusion" permanentEnchantItemId="44068" permanentenchant="3794" pickUp="PickUpCloth_Leather01" putDown="PutDownCloth_Leather01" randomPropertiesId="0" rarity="4" seed="0" slot="2"/>
            <item displayInfoId="7902" durability="0" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_shirt_yellow_01" id="4332" level="27" maxDurability="0" name="Bright Yellow Shirt" permanentenchant="0" pickUp="PickUpCloth_Leather01" putDown="PutDownCloth_Leather01" randomPropertiesId="0" rarity="1" seed="402711460" slot="3"/>
            <item displayInfoId="64565" durability="68" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_chest_cloth_48" id="50213" level="232" maxDurability="100" name="Mord'rethar Robes" permanentEnchantIcon="inv_scroll_03" permanentEnchantItemId="44465" permanentenchant="3832" pickUp="PickUpCloth_Leather01" putDown="PutDownCloth_Leather01" randomPropertiesId="0" rarity="4" seed="644057072" slot="4"/>
            <item displayInfoId="64614" durability="26" gem0Id="40008" gem1Id="0" gem2Id="0" gemIcon0="inv_jewelcrafting_gem_27" icon="inv_belt_67" id="49796" level="219" maxDurability="35" name="Essence of Anger" permanentenchant="0" pickUp="PickUpCloth_Leather01" putDown="PutDownCloth_Leather01" randomPropertiesId="0" rarity="4" seed="1571956608" slot="5"/>
            <item displayInfoId="61185" durability="53" gem0Id="40113" gem1Id="40151" gem2Id="0" gemIcon0="inv_jewelcrafting_gem_37" gemIcon1="inv_jewelcrafting_gem_39" icon="inv_pants_cloth_33" id="47785" level="232" maxDurability="75" name="Kel'Thuzad's Leggings of Conquest" permanentEnchantIcon="spell_nature_astralrecalgroup" permanentEnchantItemId="41604" permanentenchant="3721" pickUp="PickUpCloth_Leather01" putDown="PutDownCloth_Leather01" randomPropertiesId="0" rarity="4" seed="0" slot="6"/>
            <item displayInfoId="60568" durability="34" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_boots_cloth_22" id="47560" level="219" maxDurability="50" name="Boots of the Crackling Flame" permanentenchant="0" pickUp="PickUpCloth_Leather01" putDown="PutDownCloth_Leather01" randomPropertiesId="0" rarity="4" seed="959236832" slot="7"/>
            <item displayInfoId="53893" durability="26" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_bracer_17" id="37884" level="200" maxDurability="35" name="Azure Cloth Bindings" permanentenchant="0" pickUp="PickUpCloth_Leather01" putDown="PutDownCloth_Leather01" randomPropertiesId="0" rarity="4" seed="0" slot="8"/>
            <item displayInfoId="61183" durability="23" gem0Id="40113" gem1Id="0" gem2Id="0" gemIcon0="inv_jewelcrafting_gem_37" icon="inv_gauntlets_79" id="47782" level="245" maxDurability="35" name="Kel'Thuzad's Gloves of Triumph" permanentenchant="0" pickUp="PickUpCloth_Leather01" putDown="PutDownCloth_Leather01" randomPropertiesId="0" rarity="4" seed="0" slot="9"/>
            <item displayInfoId="43095" durability="0" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_jewelry_ring_54" id="47732" level="245" maxDurability="0" name="Band of the Invoker" permanentenchant="0" pickUp="PickUpRing" putDown="PutDownRing" randomPropertiesId="0" rarity="4" seed="0" slot="10"/>
            <item displayInfoId="39123" durability="0" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_jewelry_ring_57" id="47733" level="245" maxDurability="0" name="Heartmender Circle" permanentenchant="0" pickUp="PickUpRing" putDown="PutDownRing" randomPropertiesId="0" rarity="4" seed="0" slot="11"/>
            <item displayInfoId="59322" durability="0" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_misc_gem_bloodstone_03" id="48724" level="245" maxDurability="0" name="Talisman of Resurgence" permanentenchant="0" pickUp="PickUpWand" putDown="PutDownWand" randomPropertiesId="0" rarity="4" seed="0" slot="12"/>
            <item displayInfoId="44237" durability="0" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_jewelry_talisman_13" id="37873" level="200" maxDurability="0" name="Mark of the War Prisoner" permanentenchant="0" pickUp="PickUpRing" putDown="PutDownRing" randomPropertiesId="0" rarity="3" seed="1954294400" slot="13"/>
            <item displayInfoId="61405" durability="0" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_misc_cape_16" id="47089" level="245" maxDurability="0" name="Cloak of Displacement" permanentEnchantIcon="inv_scroll_03" permanentEnchantItemId="39003" permanentenchant="3831" pickUp="PickUpCloth_Leather01" putDown="PutDownCloth_Leather01" randomPropertiesId="0" rarity="4" seed="2001238400" slot="14"/>
            <item displayInfoId="64766" durability="54" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_weapon_shortblade_100" id="50227" level="232" maxDurability="75" name="Surgeon's Needle" permanentEnchantIcon="inv_scroll_03" permanentEnchantItemId="38991" permanentenchant="3830" pickUp="PickUpMetalSmall" putDown="PutDownSmallMEtal" randomPropertiesId="0" rarity="4" seed="1554421376" slot="15"/>
            <item displayInfoId="64447" durability="0" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_ore_feliron_01" id="50309" level="232" maxDurability="0" name="Shriveled Heart" permanentenchant="0" pickUp="PickUpBook" putDown="PutDownBook" randomPropertiesId="0" rarity="4" seed="1298683840" slot="16"/>
            <item displayInfoId="60586" durability="54" gem0Id="0" gem1Id="0" gem2Id="0" icon="inv_wand_32" id="47658" level="245" maxDurability="75" name="Brimstone Igniter" permanentenchant="0" pickUp="PickUpWand" putDown="PutDownWand" randomPropertiesId="0" rarity="4" seed="0" slot="17"/>
          </items>
          <glyphs>
            <glyph effect="When you use Life Tap or Dark Pact, you gain 20% of your Spirit as spell power for 40 sec." icon="ui-glyph-rune-16" id="760" name="Glyph of Life Tap" type="major"/>
            <glyph effect="Your Conflagrate spell no longer consumes your Immolate or Shadowflame spell from the target." icon="ui-glyph-rune-20" id="273" name="Glyph of Conflagrate" type="major"/>
            <glyph effect="Increases the periodic damage of your Immolate by 10%." icon="ui-glyph-rune-9" id="283" name="Glyph of Immolate" type="major"/>
          </glyphs>
        </characterTab>
        <summary>
          <c earned="184" points="1865" total="1054" totalPoints="11635"/>
          <category id="92" name="General">
            <c earned="21" earnedPoints="210" total="54" totalPoints="570"/>
          </category>
          <category id="96" name="Quests">
            <c earned="11" earnedPoints="110" total="49" totalPoints="530"/>
          </category>
          <category id="97" name="Exploration">
            <c earned="26" earnedPoints="275" total="70" totalPoints="830"/>
          </category>
          <category id="95" name="Player vs. Player">
            <c earned="35" earnedPoints="350" total="166" totalPoints="1930"/>
          </category>
          <category id="168" name="Dungeons &amp; Raids">
            <c earned="64" earnedPoints="640" total="454" totalPoints="4915"/>
          </category>
          <category id="169" name="Professions">
            <c earned="11" earnedPoints="110" total="75" totalPoints="760"/>
          </category>
          <category id="201" name="Reputation">
            <c earned="6" earnedPoints="70" total="45" totalPoints="560"/>
          </category>
          <category id="155" name="World Events">
            <c earned="10" earnedPoints="100" total="141" totalPoints="1540"/>
          </category>
          <category id="81" name="Feats of Strength">
            <c earned="4"/>
          </category>
        </summary>
      </characterInfo>
    </page>
    XML
  end

  def example_character_reputation_xml
    <<-XML
    <?xml version="1.0" encoding="UTF-8"?><?xml-stylesheet type="text/xsl" href="/_layout/character/reputation.xsl"?>
    <page globalSearch="1" lang="en_us" requestUrl="/character-reputation.xml">
      <tabInfo subTab="reputation" tab="character" tabGroup="character" tabUrl="r=Spirestone&amp;cn=Wimnock"/>
      <characterInfo>
        <character battleGroup="Reckoning" charUrl="r=Spirestone&amp;cn=Wimnock" class="Warlock" classId="9" classUrl="c=Warlock" faction="Alliance" factionId="0" gender="Male" genderId="0" guildName="" lastModified="February 16, 2010" level="80" name="Wimnock" points="1865" prefix="" race="Gnome" raceId="7" realm="Spirestone" suffix=" the Patient" titleId="137">
          <modelBasePath value="http://us.media.battle.net.edgesuite.net/"/>
        </character>
        <reputationTab>
          <faction header="1" iconKey="zzother" id="999999" key="zzother" name="Other">
            <faction id="589" key="wintersabertrainers" name="Wintersaber Trainers" reputation="0"/>
            <faction id="70" key="syndicate" name="Syndicate" reputation="-11375"/>
          </faction>
          <faction header="1" iconKey="wrathofthelichking" id="1097" key="wrathofthelichking" name="Wrath of the Lich King">
            <faction header="1" iconKey="wrathofthelichking" id="1117" key="sholazarbasin" name="Sholazar Basin">
              <faction id="1104" key="frenzyhearttribe" name="Frenzyheart Tribe" reputation="-7627"/>
              <faction id="1105" key="theoracles" name="The Oracles" reputation="5101"/>
            </faction>
            <faction id="1073" key="thekalu'ak" name="The Kalu'ak" reputation="18110"/>
            <faction id="1098" key="knightsoftheebonblade" name="Knights of the Ebon Blade" reputation="42999"/>
            <faction id="1119" key="thesonsofhodir" name="The Sons of Hodir" reputation="11522"/>
            <faction id="1090" key="kirintor" name="Kirin Tor" reputation="42999"/>
            <faction id="1091" key="thewyrmrestaccord" name="The Wyrmrest Accord" reputation="42999"/>
            <faction header="1" iconKey="wrathofthelichking" id="1037" key="alliancevanguard" name="Alliance Vanguard" reputation="42999">
              <faction id="1050" key="valianceexpedition" name="Valiance Expedition" reputation="42999"/>
              <faction id="1094" key="thesilvercovenant" name="The Silver Covenant" reputation="21387"/>
              <faction id="1068" key="explorers'league" name="Explorers' League" reputation="23065"/>
              <faction id="1126" key="thefrostborn" name="The Frostborn" reputation="19205"/>
            </faction>
            <faction id="1106" key="argentcrusade" name="Argent Crusade" reputation="10683"/>
          </faction>
          <faction header="1" iconKey="theburningcrusade" id="980" key="theburningcrusade" name="The Burning Crusade">
            <faction id="933" key="theconsortium" name="The Consortium" reputation="1000"/>
            <faction id="989" key="keepersoftime" name="Keepers of Time" reputation="0"/>
            <faction id="978" key="kurenai" name="Kurenai" reputation="9630"/>
            <faction id="946" key="honorhold" name="Honor Hold" reputation="5725"/>
            <faction id="1038" key="ogri'la" name="Ogri'la" reputation="0"/>
            <faction id="942" key="cenarionexpedition" name="Cenarion Expedition" reputation="9514"/>
            <faction id="970" key="sporeggar" name="Sporeggar" reputation="2105"/>
            <faction header="1" iconKey="theburningcrusade" id="936" key="shattrathcity" name="Shattrath City">
              <faction id="934" key="thescryers" name="The Scryers" reputation="4110"/>
              <faction id="1011" key="lowercity" name="Lower City" reputation="1650"/>
              <faction id="935" key="thesha'tar" name="The Sha'tar" reputation="2815"/>
              <faction id="932" key="thealdor" name="The Aldor" reputation="-4521"/>
              <faction id="1031" key="sha'tariskyguard" name="Sha'tari Skyguard" reputation="20"/>
            </faction>
          </faction>
          <faction header="1" iconKey="classic" id="1118" key="classic" name="Classic">
            <faction id="609" key="cenarioncircle" name="Cenarion Circle" reputation="160"/>
            <faction header="1" iconKey="classic" id="469" key="alliance" name="Alliance" reputation="17385">
              <faction id="930" key="exodar" name="Exodar" reputation="21266"/>
              <faction id="69" key="darnassus" name="Darnassus" reputation="26506"/>
              <faction id="54" key="gnomereganexiles" name="Gnomeregan Exiles" reputation="26861"/>
              <faction id="72" key="stormwind" name="Stormwind" reputation="36993"/>
              <faction id="47" key="ironforge" name="Ironforge" reputation="32587"/>
            </faction>
            <faction id="576" key="timbermawhold" name="Timbermaw Hold" reputation="7180"/>
            <faction id="92" key="gelkisclancentaur" name="Gelkis Clan Centaur" reputation="3275"/>
            <faction id="59" key="thoriumbrotherhood" name="Thorium Brotherhood" reputation="1750"/>
            <faction id="87" key="bloodsailbuccaneers" name="Bloodsail Buccaneers" reputation="-15050"/>
            <faction header="1" iconKey="classic" id="891" key="allianceforces" name="Alliance Forces">
              <faction id="509" key="theleagueofarathor" name="The League of Arathor" reputation="270"/>
              <faction id="890" key="silverwingsentinels" name="Silverwing Sentinels" reputation="445"/>
              <faction id="730" key="stormpikeguard" name="Stormpike Guard" reputation="2555"/>
            </faction>
            <faction id="93" key="magramclancentaur" name="Magram Clan Centaur" reputation="-3625"/>
            <faction id="529" key="argentdawn" name="Argent Dawn" reputation="5200"/>
            <faction id="349" key="ravenholdt" name="Ravenholdt" reputation="265"/>
            <faction header="1" iconKey="classic" id="169" key="steamwheedlecartel" name="Steamwheedle Cartel">
              <faction id="369" key="gadgetzan" name="Gadgetzan" reputation="13254"/>
              <faction id="470" key="ratchet" name="Ratchet" reputation="10475"/>
              <faction id="21" key="bootybay" name="Booty Bay" reputation="13720"/>
              <faction id="577" key="everlook" name="Everlook" reputation="10412"/>
            </faction>
          </faction>
        </reputationTab>
      </characterInfo>
    </page>
    XML
  end

  def example_character_talents_xml
    <<-XML
    <?xml version="1.0" encoding="UTF-8"?><?xml-stylesheet type="text/xsl" href="/_layout/character/talents.xsl"?><page globalSearch="1" lang="en_us" requestUrl="/character-talents.xml">
      <tabInfo subTab="talents" tab="character" tabGroup="character" tabUrl="r=Spirestone&amp;cn=Wimnock"/>
      <characterInfo>
        <character battleGroup="Reckoning" charUrl="r=Spirestone&amp;cn=Wimnock" class="Warlock" classId="9" classUrl="c=Warlock" faction="Alliance" factionId="0" gender="Male" genderId="0" guildName="" lastModified="June 23, 2010" level="80" name="Wimnock" points="0" prefix="" race="Gnome" raceId="7" realm="Spirestone" suffix=" the Patient" titleId="137">
          <modelBasePath value="http://us.media.battle.net.edgesuite.net/"/>
        </character>
        <talents>
          <talentGroup active="1" group="2" icon="ability_seal" prim="">
            <talentSpec treeOne="0" treeThree="0" treeTwo="0" value=""/>
            <glyphs>
              <glyph effect="Increases the damage done by your Imp's Firebolt spell by 20%." icon="spell_shadow_summonimp" id="284" name="Glyph of Imp" type="major"/>
              <glyph effect="Reduces the cast time of your Enslave Demon spell by 50%." icon="spell_shadow_enslavedemon" id="481" name="Glyph of Enslave Demon" type="minor"/>
              <glyph effect="Your Drain Soul restores 10% of your total mana after you kill a target that yields experience or honor." icon="spell_shadow_haunting" id="478" name="Glyph of Drain Soul" type="minor"/>
              <glyph effect="Reduces the cooldown of your Conflagrate by 2 sec." icon="spell_fire_fireball" id="273" name="Glyph of Conflagrate" type="major"/>
              <glyph effect="Increases the movement speed of your Eye of Kilrogg by 50% and allows it to fly in areas where flying mounts are enabled." icon="spell_shadow_evileye" id="479" name="Glyph of Eye of Kilrogg" type="minor"/>
              <glyph effect="Increases the periodic damage of your Immolate by 10%." icon="spell_fire_immolation" id="283" name="Glyph of Immolate" type="major"/>
            </glyphs>
          </talentGroup>
          <talentGroup group="1" icon="ability_seal" prim="">
            <talentSpec treeOne="0" treeThree="0" treeTwo="0" value=""/>
            <glyphs>
              <glyph effect="Reduces the global cooldown of your Life Tap by .5 sec." icon="spell_shadow_burningspirit" id="760" name="Glyph of Life Tap" type="major"/>
              <glyph effect="Reduces the cooldown of your Conflagrate by 2 sec." icon="spell_fire_fireball" id="273" name="Glyph of Conflagrate" type="major"/>
              <glyph effect="Increases the periodic damage of your Immolate by 10%." icon="spell_fire_immolation" id="283" name="Glyph of Immolate" type="major"/>
            </glyphs>
          </talentGroup>
        </talents>
      </characterInfo>
    </page>
    XML
  end
end
