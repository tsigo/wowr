require 'spec_helper'

module Wowr::Armory::Achievement
  describe Completed do
    context "successful DateTime.parse" do
      subject { Completed.new(fake_element) }

      its(:class)          { should superclass(Base) }
      its(:date_completed) { should be_kind_of(DateTime) }
    end

    context "unsuccessful DateTime.parse" do
      before  { DateTime.expects(:parse).raises(ArgumentError) }
      subject { Completed.new(fake_element) }

      its(:class)          { should superclass(Base) }
      its(:date_completed) { should be_kind_of(String) }
    end

    protected

    def fake_element
      xml = file_fixture('armory/character-achievements/sebudai_mal_ganis.xml')
      (Nokogiri::XML(xml)%'summary'/'achievement')[0]
    end
  end
end
