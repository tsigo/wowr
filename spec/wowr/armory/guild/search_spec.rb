require 'spec_helper'

module Wowr::Armory::Guild
  describe Search do
    subject { Search.new(fake_element) }

    its(:faction)       { should eql("Horde") }
    its(:faction_id)    { should eql(1) }
    its(:battle_group)  { should eql("Stormstrike") }
    its(:relevance)     { should satisfy { |n| n > 0 && n <= 100 } }

    # Inherited from Base
    its(:name)   { should eql("Juggernaut") }
    its(:realm)  { should eql("Mal'Ganis") }
    its(:url)    { should eql("r=Mal%27Ganis&gn=Juggernaut") }

    protected

    def fake_element
      xml = file_fixture('armory/search/guilds_juggernaut.xml')

      # Using "ends with" selector ($=) since the quote in Mal'Ganis was
      # causing problems
      (Hpricot.XML(xml).search(%{guild[@realm$="Ganis"]})[0])
    end
  end
end
