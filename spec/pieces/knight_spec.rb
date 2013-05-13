require 'spec_helper'

describe Chess::Pieces::Knight do
  describe "#can_move?(vector)" do
    let(:knight) { Chess::Pieces::Knight.new("white") }

    it "can move up 1 and over 2" do
      vector = Chess::MoveVector.new("e4", "c3")
      knight.can_move?(vector).should == true
    end

    it "can move down 1 and over 2" do
      vector = Chess::MoveVector.new("a2", "c3")
      knight.can_move?(vector).should == true
    end

    it "can move up 2 and over 1" do
      vector = Chess::MoveVector.new("b5", "c3")
      knight.can_move?(vector).should == true
    end

    it "can move down 2 and over 1" do
      vector = Chess::MoveVector.new("b1", "c3")
      knight.can_move?(vector).should == true
    end

    it "can't move down 2 and over 2" do
      vector = Chess::MoveVector.new("b1", "d3")
      knight.can_move?(vector).should == false
    end

    it "can't move up 1 and over 1" do
      vector = Chess::MoveVector.new("b2", "c3")
      knight.can_move?(vector).should == false
    end

  end
end
