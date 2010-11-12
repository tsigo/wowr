require 'spec_helper'

module Wowr::Armory::Achievement
  describe CategoryDetailsWithPoints do
    subject { CategoryDetailsWithPoints.new(fake_element) }

    its(:earned_points) { should eql(200) }
    its(:total)         { should eql(50) }
    its(:total_points)  { should eql(500) }

    its(:class) { should superclass(CategoryDetails) }

    protected

    def fake_element
      # NOTE: CategoryDetailsWithPoints actually expects a Hash, and not an Nokogiri::XML::Element instance
      {:name => '', :id => 0, :earned => "20", :earnedPoints => "200", :total => "50", :totalPoints => "500"}
    end
  end
end
