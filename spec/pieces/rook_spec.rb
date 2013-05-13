require 'spec_helper'

describe Chess::Pieces::Rook do
  describe "#can_move?(vector)" do
    let(:rook) { Chess::Pieces::Rook.new('White') }
    it "can move sideways but not up or down" do
      vector = Chess::Vector.new("b3", "c3")
      rook.can_move?(vector).should == true
    end
    
    it "can move up or down but not sideways" do
      vector = Chess::Vector.new("d4", "d8")
      rook.can_move?(vector).should == true
    end
    
    it "cannot move sideways and up and down at the same time" do
      vector = Chess::Vector.new("f5", "g4")
      rook.can_move?(vector).should == false
    end
  end
end
