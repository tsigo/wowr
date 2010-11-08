require 'spec_helper'

module Wowr::Armory::Character
  describe Faction do
    subject { Faction.new(fake_element) }

    its(:id)         { should eql(1064) }
    its(:key)        { should eql('thetaunka') }
    its(:name)       { should eql('The Taunka') }
    its(:reputation) { should eql(42999) }
    its(:header)     { should be_nil }
    its(:header?)    { should be_false }

    protected

    def fake_element
      xml = file_fixture('armory/character-reputation/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml).search("faction[@key='thetaunka']").first)
    end
  end

  describe Faction, "header" do
    subject { Faction.new(fake_element) }

    its(:id)         { should eql(999_999) }
    its(:key)        { should eql('zzother') }
    its(:name)       { should eql('Other') }
    its(:reputation) { should eql(0) }
    its(:header)     { should eql(1) }
    its(:header?)    { should be_true }

    protected

    def fake_element
      xml = file_fixture('armory/character-reputation/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml).search("faction[@header='1']").first)
    end
  end
end
