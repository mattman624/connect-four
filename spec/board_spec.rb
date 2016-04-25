require 'spec_helper.rb'

describe "Board object" do

  before :each do
    @board = Board.new
    @player_mark = "X"
  end

  describe "#new" do
    it "has a height of 6" do
      expect(@board.height).to eq(6)
    end

    it "has a width of 7" do
      expect(@board.width).to eq(7)
    end

  end

  describe "#set_piece and #get_piece" do
    let(:player_piece) { "X" }
    let(:x) { 1 }
    let(:column) { 1 }

    before :each do 
      @board.set_piece(column, player_piece) 
    end

    it "sets and gets at given location" do
      expect(@board.get_piece( 1, 1 )).to eq(player_piece)
    end

    it "stacks pieces on top of each other" do
      @board.set_piece(column, "O") 
       expect(@board.get_piece(1, 2)).to eq("O")
     end

    it "doesn't set or get outside of board" do
      @board.set_piece(8, "O")
      expect(@board.get_piece(8, 0)).to eq(nil)
    end
  end

  context "getting paths" do
    let(:column) { 1 }

    before :each do
      @board.set_piece( column, "O") 
    end

    describe "#get_horizontal_path" do
      it "returns an array of the row" do
        expect(@board.get_horizontal_path( 1 )).to eq(["O", " ", " ", " ", " ", " ", " "])
      end
    end

    describe '#get_vertical_path' do
      it "returns the virtical path" do 
        expect(@board.get_vertical_path( 1 )).to eq(["O", " ", " ", " ", " ", " "])
      end      
    end

    describe '#get_starting_row_uw' do
      it "finds the y intercept (row) of an upward sloping path" do
        expect(@board.get_starting_row_uw(2, 1)).to eq(0)
        expect(@board.get_starting_row_uw(3, 5)).to eq(3)
      end
    end

    describe '#get_upward_path' do
      it "returns array containing the upward sloping 'win' path" do
        expect(@board.get_upward_path(4, 3)).to eq([" ", " ", " ", " ", " ", " "])        
      end

      it "returns array containing the upward sloping win path" do
        @board.set_piece(2, "O")
        expect(@board.get_upward_path(4, 3)).to eq(["O", " ", " ", " ", " ", " "])
      end

      it 'handles up-left corner cases properly' do
        expect(@board.get_upward_path(2, 5)).to eq([" ", " ", " "])

      end

      it 'handles down-right corner cases properly' do
        @board.set_piece(6, "O")
        expect(@board.get_upward_path(6, 1)).to eq(["O", " "])
      end
    end

    describe '#get_starting_row_dw' do
      it 'returns the y intercept (row) of a downward sloping path' do
        expect(@board.get_starting_row_dw(4, 3)).to eq(6)
      end

      it 'returns the y intercept even if large' do
        expect(@board.get_starting_row_dw(5, 6)).to eq(10)
      end
    end

    describe '#get_downward_path' do
      it "returns array containing the downward sloping 'win' path" do
        expect(@board.get_downward_path(2, 3)).to eq([" ", " ", " ", " "])        
      end

      it "returns array containing the downward sloping win path" do
        @board.set_piece(6, "O")
        expect(@board.get_downward_path(4, 3)).to eq([" ", " ", " ", " ", " ", "O"])
      end      

      it 'handles up-right corner cases properly' do
        @board.set_piece(6, "O")
        expect(@board.get_downward_path(6, 6)).to eq([" ", " "])
      end
    end

    describe "#collect_paths" do
      it "collects the vertical, horizontal, upward, and downward paths" do
        @board.set_piece(3, "O")
        @board.set_piece(7 , "O")
        expect(@board.collect_paths(3, 5)).to eq([
          ["O", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", " ", " "], 
          [" ", " ", " ", " "], 
          [" ", " ", " ", " ", " ", "O"]
        ])
      end

      it 'collects the correct paths' do
        4.times do |time|
        @board.set_piece(time + 1, "O")
      end

      expect(@board.collect_paths(1, 1)).to eq([
          ["O", "O", " ", " ", " ", " "], 
          ["O", "O", "O", "O", " ", " ", " "], 
          ["O", " ", " ", " ", " ", " "], 
          ["O"]
        ])
      end
    end
  end

  describe "#check_win?" do
    let(:player_mark) { "X" }

    it "identifies a non-winning board" do
      expect(@board.check_win?(4, 5)).to eq(false)
    end

    it "identifies a winning horizantal win" do
      4.times do |time|
        @board.set_piece(time + 1, "O")
      end

      expect(@board.check_win?(1, 1)).to eq(true)
    end
  end

end
