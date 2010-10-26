require 'spec_helper'

module Wowr::Armory::Item
  describe SetBonus do
    subject { SetBonus.new(fake_element) }

    its(:threshold)   { should eql(1) }
    its(:description) { should eql("Set bonus description") }

    # Alias methods
    its(:desc) { should eql("Set bonus description") }
    its(:to_s) { should eql("Set bonus description") }

    protected

    def fake_element
      { :threshold => 1, :desc => "Set bonus description" }
    end
  end
end
