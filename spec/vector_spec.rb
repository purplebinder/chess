require 'spec_helper'

describe Chess::Vector do
  describe "dx" do
    it "calculates positive dx" do
      Chess::Vector.new("b2", "c3").dx.should == 1
    end
    
    it "calculates negative dx" do
      Chess::Vector.new("d2", "b4").dx.should == (-2)
    end

    it "knows when dx is 0" do
      Chess::Vector.new("f7", "f5").dx.should == 0
    end
  end

  describe "dy" do
    it "calculates positive dy" do
      Chess::Vector.new("c8", "f5").dy.should == 3
    end

    it "calculates negative dy" do
      Chess::Vector.new("g1", "h3").dy.should == -2
    end
    
    it "knows when dy is 0" do
      Chess::Vector.new("a5", "f5").dy.should == 0
    end
  end

  describe "#adjacent?" do
    it "returns true if positions are horizontally adjacent" do
      Chess::Vector.new("c3", "d3").adjacent?.should == true
    end

    it "returns true if positions are vertically adjacent" do
      Chess::Vector.new("d3", "d4").adjacent?.should == true
    end

    it "returns true if positions are diagonally adjacent" do
      Chess::Vector.new("g5", "f4").adjacent?.should == true
    end

    it "returns false if positions are not adjacent" do
      Chess::Vector.new("e6", "e8").adjacent?.should == false
    end
  end

  describe "#adjacent_position returns the position adjacent to the starting position, along the vector towards the ending position" do
    it "e5 -> e8 returns e6" do
      Chess::Vector.new("e5", "e8").adjacent_position.should == "e6"
    end

    it "a2 -> d5 returns b3" do
      Chess::Vector.new("a2", "d5").adjacent_position.should == "b3"
    end

    it "f2 -> b2 returns e2" do
      Chess::Vector.new("f2", "b2").adjacent_position.should == "e2"
    end

    it "e4 -> b1 returns d3" do
      Chess::Vector.new("e4", "b1").adjacent_position.should == "d3"
    end

  end

  describe "exceptions" do
    it "blows up if you give it bad coordinates" do
      lambda{Chess::Vector.new("a4", "j4")}.should raise_exception
    end
    it "if the start and end are the same, raise an exception" do
      lambda{Chess::Vector.new("d8", "d8")}.should raise_exception
    end
  end

  describe "#to_a" do
    it "b2 -> c2 returns [c2]" do
      Chess::Vector.new("b2", "c2").to_a.should == ["c2"]
    end
    it "e5 -> e8 returns [e6, e7, e8]" do
      Chess::Vector.new("e5", "e8").to_a.should == ["e6", "e7", "e8"]
    end
    it "a2 -> d5 returns [b3, c4, d5]" do
      Chess::Vector.new("a2", "d5").to_a.should == ["b3", "c4", "d5"]
    end
    it "f2 -> a2 returns [e2, d2, c2, b2, a2]" do
      Chess::Vector.new("f2", "a2").to_a.should == ["e2", "d2", "c2", "b2", "a2"]
    end
    it "e4 -> b1 returns [d3, c2, b1]" do
      Chess::Vector.new("e4", "b1").to_a.should == ["d3", "c2", "b1"]
    end

  end

end
