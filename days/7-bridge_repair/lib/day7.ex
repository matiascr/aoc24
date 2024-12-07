defmodule Day7 do
  @moduledoc """
  Implementation of Advent of Code Day 7: Bridge Repair.

  [Advent of Code Day 7: Bridge Repair](https://adventofcode.com/2024/day/7)
  """

  def parse_line(line) do
    [result | numbers] =
      line
      |> String.split([":", " "])
      |> Enum.filter(&(&1 != ""))

    {String.to_integer(result), numbers}
  end

  def selections(_, 0), do: [[]]

  def selections(possibilities, target_length) do
    Enum.flat_map(possibilities, fn el ->
      Enum.map(selections(possibilities, target_length - 1), &[el | &1])
    end)
  end

  def compute_variant(target, [target], _), do: true
  def compute_variant(_target, [_not_target], _), do: false

  def compute_variant(target, [f, s | next_numbers], [operator | next_operators]) do
    {res, _} = Code.eval_string("#{f} #{operator} #{s}")

    cond do
      res > target -> false
      res <= target -> compute_variant(target, [res | next_numbers], next_operators)
    end
  end

  def compute_line({target, numbers}) do
    nof_operators = length(numbers) - 1
    combinations = ["*", "+"] |> selections(nof_operators)

    true in Enum.map(combinations, &compute_variant(target, numbers, &1))
  end

  def valid_line?(line), do: line != nil

  def part_1(data_path) do
    data_path
    |> File.stream!()
    |> Enum.to_list()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_line/1)
    |> Enum.filter(&compute_line/1)
    |> Enum.map(fn {target, _} -> target end)
    |> Enum.sum()
  end
end
