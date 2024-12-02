defmodule Day2Test do
  use ExUnit.Case, async: false

  import Day2

  @data "data/data"
  @example_data "data/example"

  describe "part 1" do
    test "example" do
      res = part_1(@example_data)
      IO.puts("\tPart 1 example:\t\t#{res}")

      assert res == 2
    end

    test "data" do
      res = part_1(@data)
      IO.puts("\tPart 1 result:\t\t#{res}")

      assert res == 591
    end
  end

  describe "part 2" do
    test "example" do
      res = part_2(@example_data)
      IO.puts("\tPart 2 example:\t\t#{res}")

      assert res == 4
    end

    test "data" do
      res = part_2(@data)
      IO.puts("\tPart 2 result:\t\t#{res}")

      assert res == 621
    end
  end
end
