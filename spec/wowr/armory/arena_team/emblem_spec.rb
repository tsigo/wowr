require 'spec_helper'

module Wowr::Armory::ArenaTeam
  describe Emblem do
    subject { Emblem.new(fake_element) }

    its(:background)   { should eql("ff00b825") }
    its(:border_color) { should eql("ff240002") }
    its(:border_style) { should eql(6) }
    its(:icon_color)   { should eql("ff001440") }
    its(:icon_style)   { should eql(82) }

    protected

    def fake_element
      xml = file_fixture('armory/team-info/dont_kill_comfort_ysera.xml')
      (Hpricot.XML(xml)%'emblem')
    end
  end
end
