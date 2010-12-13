require 'spec_helper'

module Wowr::Armory::Character
  describe Base do
    subject { Base.new(fake_element) }

    its(:name)               { should eql('Sebudai') }
    its(:level)              { should eql(85) }
    its(:url)                { should eql("r=Mal%27Ganis&cn=Sebudai") }
    its(:klass)              { should eql('Hunter') }
    its(:klass_id)           { should eql(3) }
    its(:gender)             { should eql('Male') }
    its(:gender_id)          { should eql(0) }
    its(:race)               { should eql('Orc') }
    its(:race_id)            { should eql(2) }
    its(:guild)              { should eql('Juggernaut') }
    its(:guild_id)           { should eql(7386931) }
    its(:guild_url)          { should be_nil }
    its(:realm)              { should eql("Mal'Ganis") }
    its(:battle_group)       { should eql('Stormstrike') }
    its(:relevance)          { should_not be_nil }
    its(:search_rank)        { should_not be_nil }
    its(:last_login)         { should_not be_nil }
    its(:achievement_points) { should be_nil }

    # Aliased methods
    its(:to_s)          { should eql('Sebudai') }
    its(:to_i)          { should eql(85) }
    its(:last_modified) { should_not be_nil }
    its(:class_id)      { should eql(3) }
    its(:wow_class)     { should eql('Hunter') }

    describe "#icon" do
      it "should raise InvalidIconType when given an invalid icon type" do
        expect { subject.icon(:invalid) }.to raise_error(Wowr::Exceptions::InvalidIconType)
      end

      it "should use level 70 icons if character is level 70" do
        subject.instance_variable_set("@level", 70)
        subject.icon.should match(%r{wow-70/[\d-]+\.gif$})
      end

      it "should use level 80 icons if character is level 80" do
        subject.instance_variable_set("@level", 80)
        subject.icon.should match(%r{wow-80/[\d-]+\.gif$})
      end

      it "should use :other when type is nil" do
        subject.instance_variable_set("@level", 10)
        subject.icon.should match(%r{wow/[\d-]+\.gif$})
      end

      it "should use a specified type" do
        subject.icon(:default).should match(%r{wow-default/[\d-]+\.gif$})
      end

      it "should use API's base_url if given" do
        api = Wowr::API.new
        api.expects(:base_url).returns('http://google.com/')
        subject.instance_variable_set("@api", api)
        subject.icon.should match(/google.com/)
      end
    end

    describe "race_icon" do
      it "should use race_icon_url_base" do
        subject.race_icon.should match(%r{_images/icons/race/})
      end

      it "should use race_id" do
        subject.race_icon.should match(/2-0\.gif$/)
      end

      it "should use API's base_url if given" do
        api = Wowr::API.new
        api.expects(:base_url).returns('http://google.com/')
        subject.instance_variable_set("@api", api)
        subject.race_icon.should match(/google.com/)
      end
    end

    describe "class_icon" do
      it "should use class_icon_url_base" do
        subject.class_icon.should match(%r{_images/icons/class/})
      end

      it "should use klass_id" do
        subject.class_icon.should match(/3\.gif$/)
      end

      it "should use API's base_url if given" do
        api = Wowr::API.new
        api.expects(:base_url).returns('http://google.com/')
        subject.instance_variable_set("@api", api)
        subject.class_icon.should match(/google.com/)
      end
    end

    protected

    def fake_element
      xml = file_fixture('armory/search/characters_sebudai.xml')
      (Nokogiri::XML(xml)%'characters'/'character')[3]
    end
  end
end
