require 'spec_helper'

describe Chess::Board do
  describe "#move" do
    it "complains if you try to move onto your own piece" do
    end
    
    it "complains if you can't jump and you try to move through a piece" do
    end

    it "lets you capture an enemy piece" do
    end

    it "removes enemy pieces from the board when you land on them" do
    end

    it "doesn't let you play a piece if it's not your turn" do
    end
  end

  describe "#get_piece" do
    it "returns the piece at the coordinates indicated" do
    end

    it "returns nil if there's nothing there" do
    end
    
    it "is idempotent" do
    end
  end

  describe "#set_piece" do
    it "removes the piece from where it was before" do
    end

    it "puts the piece in the new position" do
    end
  end

end
