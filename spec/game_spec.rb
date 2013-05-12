require 'spec_helper'

describe Chess::Game do
  let(:game) { Chess::Game.new }
  it "can generate a string representation of a new board" do
    game.to_s.should include(<<-'board'.strip)
    a b c d e f g h
 1  R N B K Q B N R
 2  p p p p p p p p
 3  . . . . . . . .
 4  . . . . . . . .
 5  . . . . . . . .
 6  . . . . . . . .
 7  p p p p p p p p
 8  R N B K Q B N R
board
  end

  it "accepts moves as pairs of coordinates" do
    game.move("a2", "a3").should == true
  end

  it "returns false if you give it an invalid move" do
    game.move("a2", "e6").should == false
  end

  it "knows it's White's turn when the game starts" do
    game.turn.should == "White"
  end

  it "knows it's Black's turn after White makes a move" do
    game.move("a2", "a3")
    game.turn.should == "Black"
  end

  it "knows it's still White's turn after attempting an invalid move" do
    game.move("a2", "e6")
    game.turn.should == "White"
  end
end
