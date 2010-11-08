require 'spec_helper'

module Wowr::Armory::ArenaTeam
  describe Base do
    subject { Base.new(fake_element) }

    its(:name)                { should eql("LEMON") }
    its(:size)                { should eql(2) }
    its(:battle_group)        { should eql("Cyclone") }
    its(:faction)             { should eql("Horde") }
    its(:faction_id)          { should eql(1) }
    its(:realm)               { should eql("Stormscale") }
    its(:realm_url)           { should match(/b=Cyclone.+r=Stormscale.+ts=2.+select=LEMON/) }
    its(:games_played)        { should eql(0) }
    its(:games_won)           { should eql(0) }
    its(:rating)              { should eql(0) }
    its(:season_games_played) { should eql(0) }
    its(:season_games_won)    { should eql(0) }
    its(:last_season_ranking) { should eql(0) }
    its(:url)                 { should match(/r=Stormscale.+ts=2.+t=LEMON/) }
    its(:emblem)              { should be_kind_of(Emblem) }

    protected

    def fake_element
      xml = file_fixture('armory/search/arena_teams_lemon.xml')
      (Hpricot.XML(xml).search("arenaTeam[@battleGroup='Cyclone']").first)
    end
  end
end
