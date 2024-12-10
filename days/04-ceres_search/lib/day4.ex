defmodule Day4 do
  @moduledoc """
  Implementation of Advent of Code Day 4: Ceres Search.

  [Advent of Code Day 4: Ceres Search](https://adventofcode.com/2024/day/4)
  """

  @xmas ~W(X M A S)
  @samx ~w(S A M X)

  def transpose(word_search), do: word_search |> Enum.zip_with(& &1)

  def shift_left(list, 0), do: list
  def shift_left([h | t], n_places), do: (t ++ [h]) |> shift_left(n_places - 1)

  def diag(word_search) do
    [word_search, 0..length(word_search)]
    |> Enum.zip()
    |> Enum.map(fn {row, n_places} ->
      row
      |> shift_left(n_places)
      |> List.insert_at(-1 - n_places, nil)
    end)
    |> transpose()
  end

  def find_sublist([]), do: []
  def find_sublist([_, _, _]), do: []
  def find_sublist(@samx ++ rest), do: [1 | find_sublist(["X" | rest])]
  def find_sublist(@xmas ++ rest), do: [1 | find_sublist(["S" | rest])]
  def find_sublist([_ | rest]), do: find_sublist(rest)

  def find_xmas(word_search), do: Enum.map(word_search, &find_sublist/1)

  def part_1(data_path) do
    word_search =
      data_path
      |> File.stream!(:line)
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.graphemes/1)
      |> Enum.filter(&(not Enum.empty?(&1)))

    [
      # horizontal
      word_search,
      # vertical
      word_search |> transpose(),
      # diagonal right
      word_search |> diag(),
      # diagonal left
      word_search |> Enum.reverse() |> diag()
    ]
    |> Enum.map(&find_xmas/1)
    |> List.flatten()
    |> Enum.sum()
  end
end
