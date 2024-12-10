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

    {
      result
      |> String.to_integer(),
      numbers
      |> Enum.map(&String.to_integer/1)
    }
  end

  def selections(_, 0), do: [[]]

  def selections(possibilities, target_length) do
    Enum.flat_map(possibilities, fn el ->
      possibilities
      |> selections(target_length - 1)
      |> Enum.map(&[el | &1])
    end)
  end

  def compute_variant(target, [target], _), do: true
  def compute_variant(_target, [_not_target], _), do: false

  def compute_variant(target, [f, s | next_numbers], [operator | next_operators]) do
    case operator do
      "+" -> f + s
      "*" -> f * s
    end
    |> case do
      res when res > target -> false
      res when res <= target -> compute_variant(target, [res | next_numbers], next_operators)
    end
  end

  def compute_line({target, numbers}) do
    nof_operators = length(numbers) - 1
    combinations = ["*", "+"] |> selections(nof_operators)

    Enum.reduce_while(combinations, combinations, fn combination, _ ->
      if compute_variant(target, numbers, combination) do
        {:halt, true}
      else
        {:cont, false}
      end
    end)
  end

  def valid_line?(line), do: line != nil

  def part_1(data_path) do
    data_path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&parse_line/1)
    |> Stream.filter(&compute_line/1)
    |> Stream.map(fn {target, _} -> target end)
    |> Enum.sum()
  end
end
