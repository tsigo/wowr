require 'spec_helper'

module Wowr::Armory::Character
  describe Full do
    subject { Full.new(*fake_element) }

    its(:class) { should superclass(Info) }

    describe "reputation" do
      it "should return an Array of Faction instances" do
        subject.reputation.should be_kind_of(Array)
        subject.reputation[0].should be_kind_of(Faction)
      end
    end

    protected

    def fake_element
      pages = []

      %w(sheet reputation talents).each do |page|
        xml = file_fixture("armory/character-#{page}/sebudai_mal_ganis.xml")
        pages << (Nokogiri::XML(xml)%'page')
      end

      pages
    end
  end
end
