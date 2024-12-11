defmodule Day11 do
  @moduledoc """
  Implementation of Advent of Code Day 11: Plutonian Pebbles.

  [Advent of Code Day 11: Plutonian Pebbles](https://adventofcode.com/2024/day/11)
  """

  import Integer

  def split_number(number) do
    digits = number |> digits()
    nof_digits = digits |> length()

    [
      digits
      |> Enum.take(div(nof_digits, 2))
      |> undigits(),
      digits
      |> Enum.reverse()
      |> Enum.take(div(nof_digits, 2))
      |> Enum.reverse()
      |> undigits()
    ]
  end

  def blink(stones, 0), do: Enum.count(stones)

  def blink(stones, n) do
    Stream.flat_map(stones, fn stone ->
      case stone do
        0 ->
          [1]

        1 ->
          [2024]

        stone ->
          if stone |> digits() |> length() |> is_even(),
            do: split_number(stone),
            else: [stone * 2024]
      end
    end)
    |> blink(n - 1)
  end

  def get_stones(data_path) do
    data_path
    |> File.stream!()
    |> Stream.flat_map(&String.split/1)
    |> Stream.map(&String.to_integer/1)
  end

  def part_1(data_path) do
    data_path
    |> get_stones()
    |> blink(25)
  end
end
