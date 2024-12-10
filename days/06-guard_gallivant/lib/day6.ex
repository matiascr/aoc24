defmodule Day6 do
  @moduledoc """
  Implementation of Advent of Code Day 6: Guard Gallivant.

  [Advent of Code Day 6: Guard Gallivant](https://adventofcode.com/2024/day/6)
  """

  def traverse_before([]), do: []
  def traverse_before([">"]), do: ["X"]
  def traverse_before([x]), do: [x]
  def traverse_before([">" | rest]), do: traverse_after([">" | rest])
  def traverse_before([x | rest]), do: [x | traverse_before(rest)]

  def traverse_after([]), do: []
  def traverse_after([">"]), do: ["X"]
  def traverse_after([x]), do: [x]
  def traverse_after([">", "#" | rest]), do: [">", "#" | rest]
  def traverse_after([">", _ | rest]), do: ["X" | traverse_after([">" | rest])]

  def traverse(lines) do
    Enum.map(lines, &if(">" in &1, do: traverse_before(&1), else: &1))
  end

  def transpose(map) when is_list(map) do
    map
    |> Enum.map(&Enum.reverse/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def transpose(map, 1), do: transpose(map)
  def transpose(map, x) when x > 1, do: map |> transpose() |> transpose(x - 1)

  def orient(map) do
    flat_map = List.flatten(map)

    cond do
      ">" in flat_map -> map |> replace_symbol()
      "v" in flat_map -> map |> replace_symbol() |> transpose()
      "<" in flat_map -> map |> replace_symbol() |> transpose(2)
      "^" in flat_map -> map |> replace_symbol() |> transpose(3)
    end
  end

  def replace_symbol(map) do
    Enum.map(map, fn line ->
      Enum.map(line, fn item ->
        if item in ["^", "v", "<"], do: ">", else: item
      end)
    end)
  end

  def to_map(data_path) do
    data_path
    |> File.stream!()
    |> Enum.to_list()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.graphemes/1)
  end

  def patrol(map) do
    if ">" not in List.flatten(map), do: map, else: map |> traverse() |> transpose() |> patrol()
  end

  def part_1(data_path) do
    data_path
    |> to_map()
    |> orient()
    |> patrol()
    |> List.flatten()
    |> Enum.count(&(&1 == "X"))
  end
end
