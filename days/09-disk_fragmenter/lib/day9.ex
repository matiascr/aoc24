defmodule Day9 do
  @moduledoc """
  Implementation of Advent of Code Day 9: Disk Fragmenter.

  [Advent of Code Day 9: Disk Fragmenter](https://adventofcode.com/2024/day/9)
  """

  def to_disk_map(data_path) do
    data_path
    |> File.stream!(1)
    |> Stream.filter(&(&1 != "\n"))
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list()
  end

  def classify(disk_map) do
    disk_map
    |> Stream.chunk_every(2)
    |> Stream.map(fn
      [l, r] when is_integer(l) and is_integer(r) -> {{:file, l}, {:free, r}}
      [o] when is_integer(o) -> {:file, o}
    end)
    |> Stream.with_index()
  end

  def fill(n, _) when n == 0, do: []
  def fill(n, x), do: [x | fill(n - 1, x)]

  def compact(classified_disk_map) do
    classified_disk_map
    |> Enum.map(fn
      {{{:file, l}, {:free, r}}, index} -> [fill(l, index) | fill(r, ".")]
      {{:file, o}, index} -> fill(o, index)
    end)
    |> List.flatten()
  end

  def remove_last([]), do: []
  def remove_last([_]), do: []

  def remove_last(list) do
    [_ | t] = Enum.reverse(list)
    t |> Enum.reverse()
  end

  def rearrange([]), do: []
  def rearrange([first | rest]) when first != ".", do: [first | rearrange(rest)]

  def rearrange(["." | rest]) do
    case List.last(rest) do
      "." -> ["." | rest |> remove_last()] |> rearrange()
      x -> [x | rest |> remove_last() |> rearrange()]
    end
  end

  def checksum(disk_map) do
    compact = rearrange(disk_map)

    {
      compact
      |> Enum.join()
      |> String.trim_trailing("."),
      compact
      |> Stream.filter(&is_integer/1)
      |> Stream.with_index()
      |> Stream.map(fn {item, index} -> item * index end)
      |> Enum.sum()
    }
  end

  def part_1(data_path) do
    data_path
    |> to_disk_map()
    |> classify()
    |> compact()
    |> checksum()
  end
end
