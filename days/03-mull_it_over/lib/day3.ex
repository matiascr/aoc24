defmodule Day3 do
  @moduledoc """
  Implementation of Advent of Code Day 3: Mull It Over.

  [Advent of Code Day 3: Mull It Over](https://adventofcode.com/2024/day/3)
  """

  @doc """
  The computer appears to be trying to run a program, but its memory (your 
  puzzle input) is corrupted. All of the instructions have been jumbled up!

  It seems like the goal of the program is just to multiply some numbers. It 
  does that with instructions like mul(X,Y), where X and Y are each 1-3 digit 
  numbers. For instance, mul(44,46) multiplies 44 by 46 to get a result of 
  2024. Similarly, mul(123,4) would multiply 123 by 4.

  However, because the program's memory has been corrupted, there are also many 
  invalid characters that should be ignored, even if they look like part of a 
  mul instruction. Sequences like mul(4*, mul(6,9!, ?(12,34), or mul ( 2 , 4 ) 
  do nothing.
  """
  def part_1(data_path) do
    data_path
    |> File.stream!()
    |> Stream.map(&String.split(&1, ["mul(", ")"]))
    |> Stream.concat()
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(fn
      [l, r] ->
        case {Integer.parse(l), Integer.parse(r)} do
          {{l_int, ""}, {r_int, ""}} -> l_int * r_int
          _ -> 0
        end

      _ ->
        0
    end)
    |> Enum.sum()
  end
end
