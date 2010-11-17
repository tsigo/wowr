require 'spec_helper'

module Wowr::Armory::Dungeon
  describe Bosses do
    before do
      @bosses = Bosses.new
      @bosses[1, 'onyxia'] = 'Onyxia'
    end

    it "should allow access via id" do
      @bosses[1].should eql("Onyxia")
    end

    it "should allow acccess via key" do
      @bosses['onyxia'].should eql("Onyxia")
    end

    it "should only store one value" do
      @bosses.size.should eql(1)
    end
  end
end
