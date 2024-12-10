defmodule Day10 do
  @moduledoc """
  Implementation of Advent of Code Day 10: Hoof It.

  [Advent of Code Day 10: Hoof It](https://adventofcode.com/2024/day/10)
  """

  @adjacent [
    {00, +1},
    {+1, 00},
    {00, -1},
    {-1, 00}
  ]

  def value_index_to_coordinate({line, i}) do
    line
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
    |> Enum.map(fn {v, j} -> {{i, j}, v} end)
  end

  def parse_grid(data_path) when is_binary(data_path) do
    data_path
    |> File.stream!()
    |> Enum.filter(&(&1 != "\n"))
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.graphemes/1)
    |> Enum.with_index()
    |> Enum.flat_map(&value_index_to_coordinate/1)
    |> Enum.into(%{})
  end

  def find_end(grid, position), do: find_next(grid, position, 0)

  def find_next(grid, position, 9) do
    if grid[position] == 9, do: [position], else: []
  end

  def find_next(grid, position = {x, y}, value) do
    case grid[position] do
      ^value ->
        @adjacent
        |> Enum.map(fn {i, j} -> {i + x, j + y} end)
        |> Enum.flat_map(fn next -> find_next(grid, next, value + 1) end)

      _ ->
        []
    end
  end

  def find_trailheads(grid) when is_map(grid) do
    grid
    # Find starting positions
    |> Enum.filter(fn {_, v} -> v == 0 end)
    |> Enum.map(fn {pos, _} -> pos end)
    # Traverse trails
    |> Enum.map(fn start_position -> find_end(grid, start_position) end)
    # Filter by unique trail ending positions
    |> Enum.map(fn path -> Enum.uniq(path) end)
    # Get the score of the trailhead
    |> Enum.map(fn trail -> length(trail) end)
  end

  def part_1(data_path) do
    data_path
    |> parse_grid()
    |> find_trailheads()
    |> Enum.sum()
  end
end
