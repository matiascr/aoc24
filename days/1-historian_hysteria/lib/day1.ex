defmodule Day1 do
  @moduledoc """
  Implementation of Advent of Code Day 1: Historian Hysteria.

  [Advent of Code Day 1: Historian Hysteria](https://adventofcode.com/2024/day/1)
  """

  @doc ~S"""
  Pair up the smallest number in the left list with the smallest number in the
  right list, then the second-smallest left number with the second-smallest
  right number, and so on.

  Within each pair, figure out how far apart the two numbers are; you'll need
  to add up all of those distances.
  """
  def part_1(data_path) do
    File.stream!(data_path)
    |> Stream.map(fn line ->
      String.split(line)
      |> Stream.map(&String.to_integer/1)
      |> Enum.to_list()
      |> List.to_tuple()
    end)
    |> Enum.unzip()
    |> Tuple.to_list()
    |> Stream.map(&Enum.sort/1)
    |> Enum.zip()
    |> Stream.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end
end
