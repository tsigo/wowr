require 'spec_helper'

module Wowr::Armory::Guild
  describe Base, "guild-info" do
    subject { Base.new(fake_element) }

    its(:name)  { should eql("Juggernaut") }
    its(:realm) { should eql("Mal'Ganis") }
    its(:url)   { should eql("r=Mal%27Ganis&gn=Juggernaut") }

    # Aliased methods
    its(:to_s) { should eql("Juggernaut") }

    protected

    def fake_element
      xml = file_fixture('armory/guild-info/juggernaut_mal_ganis.xml')
      (Nokogiri::XML(xml)%'page')
    end
  end

  describe Base, "search" do
    subject { Base.new(fake_element) }

    its(:name)  { should eql("Juggernaut") }
    its(:realm) { should eql("Mal'Ganis") }
    its(:url)   { should eql("r=Mal%27Ganis&gn=Juggernaut") }

    # Aliased methods
    its(:to_s) { should eql("Juggernaut") }

    protected

    def fake_element
      xml = file_fixture('armory/search/guilds_juggernaut.xml')
      (Nokogiri::XML(xml).search(%{guild[@realm$="Ganis"]})[0])
    end
  end
end
