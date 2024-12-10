defmodule Day9Test do
  use ExUnit.Case, async: false

  import Day9

  @data "data/data"
  @example_data1 "data/example1"
  @example_data2 "data/example2"

  describe "part 1" do
    test "example 1" do
      {res, checksum} = part_1(@example_data1)
      IO.puts("\tPart 1 example 1:\t\t#{checksum}")

      assert res == "0099811188827773336446555566"
      assert checksum == 1_928
    end

    test "example 2" do
      {res, checksum} = part_1(@example_data2)
      IO.puts("\tPart 1 example 2:\t\t#{checksum}")

      assert res == "022111222"
      assert checksum == 60
    end

    test "data" do
      {_res, checksum} = part_1(@data)
      IO.puts("\tPart 1 result:\t\t#{checksum}")

      assert checksum == 6_334_655_979_668
    end
  end
end
