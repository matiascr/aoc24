defmodule Day10Test do
  use ExUnit.Case, async: false

  import Day10

  @data "data/data"
  @example_1_data "data/example1"
  @example_2_data "data/example2"
  @example_3_data "data/example3"

  describe "part 1" do
    test "example 1" do
      res = part_1(@example_1_data)
      IO.puts("\tPart 1 example 1:\t\t#{res}")

      assert res == 1
    end

    test "example 2" do
      res = part_1(@example_2_data)
      IO.puts("\tPart 1 example 2:\t\t#{res}")

      assert res == 36
    end

    test "example 3" do
      res = part_1(@example_3_data)
      IO.puts("\tPart 3 example 3:\t\t#{res}")

      assert res == 2
    end

    test "data" do
      res = part_1(@data)
      IO.puts("\tPart 1 result:\t\t#{res}")

      assert res == 796
    end
  end
end
