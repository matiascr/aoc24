defmodule Day1Test do
  use ExUnit.Case, async: false

  import Day1

  @data "data/data"
  @example_data "data/example"

  describe "part 1" do
    test "example" do
      res = part_1(@example_data)
      IO.puts("\tPart 1 example:\t\t#{res}")

      assert res == 11
    end

    test "data" do
      res = part_1(@data)
      IO.puts("\tPart 1 result:\t\t#{res}")

      assert res == 2_344_935
    end
  end
end
