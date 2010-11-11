require 'spec_helper'

module Wowr::Armory::Character
  describe Info do
    context "ideal situation" do
      subject { Info.new(*fake_element) }

      its(:class) { should superclass(Base) }

      its(:name)          { should eql('Sebudai') }
      its(:title)         { should match(/%s/) }
      its(:level)         { should satisfy { |v| v >= 80 } }
      its(:char_url)      { should match(/Mal%27Ganis.+Sebudai/) }
      its(:klass)         { should eql('Hunter') }
      its(:klass_id)      { should eql(3) }
      its(:gender)        { should eql('Male') }
      its(:gender_id)     { should eql(0) }
      its(:race)          { should eql('Orc') }
      its(:race_id)       { should eql(2) }
      its(:faction)       { should eql('Horde') }
      its(:faction_id)    { should eql(1) }
      its(:guild)         { should eql('Juggernaut') }
      its(:guild_url)     { should match(/Mal%27Ganis.+Juggernaut/) }
      its(:points)        { should satisfy { |v| v > 9000 } }
      its(:realm)         { should eql("Mal'Ganis") }
      its(:battle_group)  { should eql('Stormstrike') }
      its(:last_modified) { should be_kind_of(DateTime) }

      describe "arena_teams" do
        it "should be an Array of ArenaTeam instances" do
          subject.arena_teams.should be_kind_of(Array)
          subject.arena_teams[0].should be_kind_of(Wowr::Armory::ArenaTeam::Base)
        end
      end

      its(:health)     { should be_kind_of(Integer) }
      its(:second_bar) { should be_kind_of(SecondBar) }

      its(:agility)   { should be_kind_of(BaseStats::Agility) }
      its(:intellect) { should be_kind_of(BaseStats::Intellect) }
      its(:spirit)    { should be_kind_of(BaseStats::Spirit) }
      its(:stamina)   { should be_kind_of(BaseStats::Stamina) }
      its(:strength)  { should be_kind_of(BaseStats::Strength) }

      its(:melee)    { should be_kind_of(Melee) }
      its(:ranged)   { should be_kind_of(Ranged) }
      its(:spell)    { should be_kind_of(Spell) }
      its(:defenses) { should be_kind_of(Defenses) }

      its(:talent_spec) { should be_kind_of(TalentSpec) }
      its(:pvp)         { should be_kind_of(Pvp) }

      describe "resistances" do
        it "should be a Hash of Resistance instances" do
          subject.resistances.should be_kind_of(Hash)
          subject.resistances['shadow'].should be_kind_of(Resistance)
        end
      end

      describe "all_talent_specs" do
        it "should be an Array of TalentSpec instances" do
          subject.all_talent_specs.should be_kind_of(Array)
          subject.all_talent_specs.length.should eql(2)
          subject.all_talent_specs[0].should be_kind_of(TalentSpec)
        end
      end

      describe "professions" do
        it "should be an Array of Skill instances" do
          subject.professions.should be_kind_of(Array)
          subject.professions[0].should be_kind_of(Skill)
        end
      end

      describe "secondary_professions" do
        it "should be an Array of Skill instances" do
          subject.secondary_professions.should be_kind_of(Array)
          subject.secondary_professions[0].should be_kind_of(Skill)
        end
      end

      describe "items" do
        it "should be an Array of EquippedItem instances" do
          subject.items.should be_kind_of(Array)
          subject.items[0].should be_kind_of(EquippedItem)
        end
      end

      # Aliased methods

      its(:agi) { should_not be_nil }
      its(:int) { should_not be_nil }
      its(:spi) { should_not be_nil }
      its(:sta) { should_not be_nil }
      its(:str) { should_not be_nil }
    end

    context "unsuccessful DateTime.parse" do
      before do
        DateTime.expects(:parse).raises(ArgumentError)
      end

      subject { Info.new(*fake_element) }
      its(:last_modified) { should be_kind_of(String) }
    end

    protected

    def fake_element
      pages = []

      %w(sheet talents).each do |page|
        xml = file_fixture("armory/character-#{page}/sebudai_mal_ganis.xml")
        pages << (Hpricot.XML(xml)%'page')
      end

      pages
    end
  end

  describe Info, "expired character" do
    it "should raise CharacterNoInfo" do
      expect { Info.new(*fake_element) }.to raise_error(Wowr::Exceptions::CharacterNoInfo)
    end

    protected

    def fake_element
      pages = []

      %w(sheet talents).each do |page|
        xml = file_fixture("armory/character-#{page}/kamien_mal_ganis.xml")
        pages << (Hpricot.XML(xml)%'page')
      end

      pages
    end
  end
end
