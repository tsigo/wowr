require 'spec_helper'

module Wowr::Classes
  describe Money do
    it "should parse a small amount of copper" do
      money = Money.new(43)
      money.gold.should eql(0)
      money.silver.should eql(0)
      money.copper.should eql(43)
    end

    it "should parse a small amount of gold" do
      money = Money.new(5_552_243)
      money.gold.should eql(555)
      money.silver.should eql(22)
      money.copper.should eql(43)
    end

    it "should parse a large amount of gold" do
      money = Money.new(9_949_906_902)
      money.gold.should eql(994_990)
      money.silver.should eql(69)
      money.copper.should eql(2)
    end

    it "should have an addition method" do
      base = Money.new(10)
      (base + Money.new(30)).copper.should eql(40)
    end

    it "should have a subtraction method" do
      base = Money.new(60)
      (base - Money.new(10)).copper.should eql(50)
    end
  end
end
