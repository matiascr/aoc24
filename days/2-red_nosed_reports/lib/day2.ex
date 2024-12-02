defmodule Day2 do
  @moduledoc """
  Implementation of Advent of Code Day 2: Red-Nosed Reports.

  [Advent of Code Day 2: Red-Nosed Reports](https://adventofcode.com/2024/day/2)
  """

  @doc false
  defp all_increasing?([_]), do: true
  defp all_increasing?([h, s | t]), do: h < s and all_increasing?([s | t])

  @doc false
  defp all_decreasing?([_]), do: true
  defp all_decreasing?([h, s | t]), do: h > s and all_decreasing?([s | t])

  @doc false
  defp levels_differ?([_]), do: true
  defp levels_differ?([h, s | t]), do: abs(h - s) in 1..3 and levels_differ?([s | t])

  @doc false
  defp is_safe?(report) do
    (all_decreasing?(report) || all_increasing?(report)) &&
      levels_differ?(report)
  end

  @doc ~S"""
  The engineers are trying to figure out which reports are safe. The Red-Nosed 
  reactor safety systems can only tolerate levels that are either gradually 
  increasing or gradually decreasing. So, a report only counts as safe if both 
  of the following are true:

  - The levels are either all increasing or all decreasing.
  - Any two adjacent levels differ by at least one and at most three.
  """
  def part_1(data_path) do
    File.stream!(data_path)
    |> Stream.map(fn line ->
      line
      |> String.split()
      |> Stream.map(&String.to_integer/1)
      |> Enum.to_list()
    end)
    |> Stream.filter(&is_safe?/1)
    |> Enum.count()
  end
end
