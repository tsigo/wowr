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

  describe Armory, "#faction" do
    Armory::FACTIONS.each_with_index do |val, i|
      it "should map #{i} to #{val}" do
        Armory.faction(i).should eql(val)
      end
    end

    it "should raise ArgumentError when given an invalid value" do
      expect { Armory.faction(10) }.to raise_error(ArgumentError, /invalid faction/)
    end
  end

  describe Armory, "#power_type" do
    Armory::POWER_TYPES.each_pair do |k, v|
      it "should map #{k} to #{v}" do
        Armory.power_type(k).should eql(v)
      end
    end

    it "should raise ArgumentError when given an invalid value" do
      expect { Armory.power_type(:z) }.to raise_error(ArgumentError, /invalid power type/)
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
