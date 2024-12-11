defmodule Day11Test do
  use ExUnit.Case, async: false

  import Day11

  @data "data/data"
  @example_data "data/example"

  describe "part 1" do
    test "example" do
      res = part_1(@example_data)
      IO.puts("\tPart 1 example:\t\t#{res}")

      assert res == 55_312
    end

    test "data" do
      res = part_1(@data)
      IO.puts("\tPart 1 result:\t\t#{res}")

      assert res == 222_461
    end
  end
end
