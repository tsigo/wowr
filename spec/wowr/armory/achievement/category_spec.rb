require 'spec_helper'

module Wowr::Armory::Achievement
  describe Category do
    subject { Category.new(fake_element) }

    its(:name)          { should eql("Quests") }
    its(:id)            { should eql(96) }
    its(:parent)        { should be_nil }
    its(:subcategories) { should eql([]) }

    describe "add_subcategory" do
      let(:sub) { (fake_element.search('category').first) }

      it "should assign parent" do
        expect { subject.add_subcategory(sub) }.to change(sub, :parent).to(subject)
      end

      it "should add to subcategories" do
        subject.add_subcategory(sub)
        subject.subcategories.should eql([sub])
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/character-achievements/sebudai_mal_ganis.xml')
      (Hpricot.XML(xml).search("category[@id=96]").first)
    end
  end
end
