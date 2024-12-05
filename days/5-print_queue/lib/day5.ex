defmodule Day5 do
  @moduledoc """
  Implementation of Advent of Code Day 5: Print Queue.

  [Advent of Code Day 5: Print Queue](https://adventofcode.com/2024/day/5)
  """

  def format_rules(rules) do
    Enum.reduce(rules, %{}, fn [l, r], acc ->
      case Map.get(acc, l) do
        nil -> Map.put(acc, l, [r])
        _ -> Map.put(acc, l, Map.get(acc, l) ++ [r])
      end
    end)
  end

  def after?(is: l, after: r, according_to: rules) do
    case rules[r] do
      nil -> false
      elems -> l in elems
    end
  end

  def right_order?([_], _rules), do: true

  def right_order?([h | t], rules) do
    Enum.reduce(t, true, fn e, acc -> acc and after?(is: h, after: e, according_to: rules) end) and
      right_order?(t, rules)
  end

  def part_1(data_path) do
    [rules, update] =
      data_path
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Stream.chunk_by(&String.contains?(&1, "|"))
      |> Stream.map(&List.flatten/1)
      |> Stream.map(&Enum.map(&1, fn line -> String.split(line, [",", "|"]) end))
      |> Stream.map(&Enum.filter(&1, fn line -> line != [""] end))
      |> Stream.map(
        &Enum.map(&1, fn line ->
          Enum.map(line, fn n ->
            String.to_integer(n)
          end)
        end)
      )
      |> Enum.to_list()

    rules =
      format_rules(rules)

    update
    |> Enum.map(&Enum.reverse/1)
    |> Enum.filter(&right_order?(&1, rules))
    |> Enum.map(&Enum.at(&1, (length(&1) - 1) |> div(2)))
    |> Enum.sum()
  end
end
