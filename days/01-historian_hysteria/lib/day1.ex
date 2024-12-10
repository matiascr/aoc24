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

  @doc ~S"""
  Figure out exactly how often each number from the left list appears in the
  right list. Calculate a total similarity score by adding up each number in
  the left list after multiplying it by the number of times that number appears
  in the right list.
  """
  def part_2(data_path) do
    File.stream!(data_path)
    |> Stream.map(fn line ->
      String.split(line)
      |> Stream.map(&String.to_integer/1)
      |> Enum.to_list()
      |> List.to_tuple()
    end)
    |> Enum.unzip()
    |> then(fn {l, r} ->
      Enum.map(l, fn n ->
        case Enum.frequencies(r)[n] do
          nil -> 0
          freq -> n * freq
        end
      end)
    end)
    |> Enum.sum()
  end
end
