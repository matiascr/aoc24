defmodule Day8 do
  @moduledoc """
  Implementation of Advent of Code Day 8: Resonant Collinearity.

  [Advent of Code Day 8: Resonant Collinearity](https://adventofcode.com/2024/day/8)
  """

  def to_map(lines) do
    lines
    |> Stream.filter(&(&1 != "\n"))
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.graphemes/1)
    |> Stream.with_index()
    |> Stream.flat_map(fn {line, x_index} ->
      line
      |> Stream.with_index()
      |> Stream.map(fn {value, y_index} -> {{x_index, y_index}, value} end)
    end)
    |> Enum.into(%{})
  end

  def get_pairs(list), do: combinations(list, 2) |> Enum.uniq()

  def combinations(_, 0), do: [[]]
  def combinations([], _), do: []

  def combinations([h | t], n) do
    Enum.flat_map(combinations(t, n - 1), &[[h | &1] | combinations(t, n)])
  end

  def find_position_pairs(map) do
    map
    |> Enum.filter(fn {_, v} -> v != "." end)
    |> Enum.uniq()
    |> Enum.group_by(fn {_, value} -> value end)
    |> Enum.map(fn {_, positions} -> positions end)
    |> Enum.filter(fn positions -> Enum.count(positions) > 1 end)
    |> Enum.flat_map(&get_pairs/1)
    |> Enum.map(fn [{l, v}, {r, v}] -> {l, r} end)
  end

  def apply_pair_antinodes({{lx, ly}, {rx, ry}}, map) do
    [
      {lx + (lx - rx), ly + (ly - ry)},
      {rx - (lx - rx), ry - (ly - ry)}
    ]
    |> Enum.reduce(map, fn pos, map ->
      case Map.get(map, pos) do
        nil -> map
        _ -> Map.put(map, pos, "#")
      end
    end)
  end

  def print_map(map) do
    map
    |> Enum.sort()
    |> Enum.map(fn {{_, _}, value} -> value end)
    |> Enum.chunk_every(
      map
      |> Enum.map(fn {{_, x}, _} -> x end)
      |> Enum.max()
      |> Kernel.+(1)
    )
    |> Enum.join("\n")
    |> IO.puts()

    map
  end

  def apply_antinodes(map) do
    map
    |> find_position_pairs()
    |> Enum.reduce(map, &apply_pair_antinodes(&1, &2))
    # |> print_map()
    |> Enum.filter(fn
      {{_, _}, "#"} -> true
      _ -> false
    end)
    |> Enum.count()
  end

  def part_1(data_path) do
    data_path
    |> File.stream!()
    |> to_map()
    |> apply_antinodes()
  end
end
