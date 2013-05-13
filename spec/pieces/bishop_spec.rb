require 'spec_helper'

describe Chess::Pieces::Bishop do
  describe "#can_move?(vector)" do
    let(:bishop) { Chess::Pieces::Bishop.new('Black') }

    it "can move up 3 and over 3" do
      vector = Chess::Vector.new("a5", "d2")
      bishop.can_move?(vector).should == true
    end

    it "can move down 1 and over 1" do
      vector = Chess::Vector.new("g4", "f5")
      bishop.can_move?(vector).should == true
    end

    it "cannot move up 3 and over 2" do
      vector = Chess::Vector.new("d4", "f1")
      bishop.can_move?(vector).should == false
    end

    it "cannot move up 0 and over 5" do
      vector = Chess::Vector.new("b4", "g4")
      bishop.can_move?(vector).should == false
    end

    it "cannot move down 5 and over 0" do
      vector = Chess::Vector.new("c2", "c7")
      bishop.can_move?(vector).should == false
    end

  end
end
