require 'spec_helper'

module Wowr::Armory::ArenaTeam
  describe Full do
    subject { Full.new(fake_element) }

    its(:class) { should superclass(Base) }

    describe "members" do
      it "should return a hash of Character::Base instances" do
        members = subject.members
        members.should be_kind_of(Hash)

        name, instance = subject.members.first
        name.should be_kind_of(String)
        instance.should be_kind_of(Wowr::Armory::Character::Base)
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/team-info/dont_kill_comfort_ysera.xml')
      (Hpricot.XML(xml)%'arenaTeam')
    end
  end
end
