require 'spec_helper'

module Wowr
  describe Armory, "#damage_type" do
    Armory::DAMAGE_TYPES.each_with_index do |val, i|
      it "should map #{i} to #{val}" do
        Armory.damage_type(i).should eql(val)
      end
    end

    it "should raise ArgumentError when given an invalid value" do
      expect { Armory.damage_type(10) }.to raise_error(ArgumentError, /invalid damage type/)
    end
  end

  describe Armory, "#quality" do
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
