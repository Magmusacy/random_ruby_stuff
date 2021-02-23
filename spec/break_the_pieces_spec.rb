require './break_the_pieces/break_the_pieces'

describe "#break_pieces" do
  it "returns distinct shapes from one shape with extraction points" do
    shape = ["+------------+",
            "|            |",
            "|            |",
            "|            |",
            "+------+-----+",
            "|      |     |",
            "|      |     |",
            "+------+-----+"].join("\n")

    solution = [["+------------+",
              "|            |",
              "|            |",
              "|            |",
              "+------------+"].join("\n"),
            ["+------+",
              "|      |",
              "|      |",
              "+------+"].join("\n"),
            ["+-----+",
              "|     |",
              "|     |",
              "+-----+"].join("\n")]
    expect(break_pieces(shape)).to eql(solution)
  end

  it "different case" do
    shape = ["    +---+",
             "    |   |",
             "+---+   |",
             "|       |",
             "+-------+"].join("\n")

    solution = ["    +---+",
                "    |   |",
                "+---+   |",
                "|       |",
                "+-------+"].join("\n")

    expect(break_pieces(shape)).to eql(solution)
  end

  it "different case 2" do
    shape = ["    +---+",
             "    |   |",
             "+---+---+",
             "|       |",
             "+-------+"].join("\n")

    solution = [["+---+",
                 "|   |",
                 "+---+"].join("\n"),
                ["+-------+",
                 "|       |",
                 "+-------+"].join("\n") 
              ]

    expect(break_pieces(shape)).to eql(solution)
  end
end