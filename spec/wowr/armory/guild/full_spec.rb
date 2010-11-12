require 'spec_helper'

module Wowr::Armory::Guild
  describe Full do
    subject { Full.new(fake_element) }

    its(:name_url)     { should eql("Juggernaut") }
    its(:realm_url)    { should eql("Mal%27Ganis") }
    its(:members)      { should be_a(Hash) }
    its(:member_count) { should satisfy { |n| n > 0 && n <= 1000 } }

    describe "members hash" do
      it "should contain 'Name' => Character instance pairs" do
        subject.members.first[0].should be_a(String)
        subject.members.first[1].should be_a(Wowr::Classes::Character)
      end
    end

    its(:class) { should superclass(Wowr::Armory::Guild::Base) }

    protected

    def fake_element
      xml = file_fixture('armory/guild-info/juggernaut_mal_ganis.xml')
      (Nokogiri::XML(xml)%'page')
    end
  end
end
