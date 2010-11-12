require 'spec_helper'

module Wowr::Armory::ArenaTeam
  describe SearchResult do
    subject { SearchResult.new(fake_element) }

    its(:class) { should superclass(Base) }

    its(:relevance) { should_not be_nil }

    protected

    def fake_element
      xml = file_fixture('armory/search/arena_teams_lemon.xml')
      (Nokogiri::XML(xml).search("arenaTeam[@battleGroup='Cyclone']").first)
    end
  end
end
