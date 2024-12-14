defmodule Day14Test do
  use ExUnit.Case, async: false

  import Day14

  @data "data/data"
  @example_data "data/example"

  describe "part 1" do
    test "example" do
      res = part_1(@example_data, 11, 7)
      IO.puts("\tPart 1 example:\t\t#{res}")

      assert res == 12
    end

    test "data" do
      res = part_1(@data, 101, 103)
      IO.puts("\tPart 1 result:\t\t#{res}")

      assert res == 218_619_120
    end
  end
end
