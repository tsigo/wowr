require 'spec_helper'

module Wowr
  describe Armory, ".quality" do
    Armory::QUALITIES.each_with_index do |val, i|
      it "should map #{i} to #{val}" do
        Armory.quality(i).should eql(val)
      end
    end

    it "should raise ArgumentError when given an invalid value" do
      expect { Armory.quality(10) }.to raise_error(ArgumentError, /invalid quality/)
    end
  end
end
