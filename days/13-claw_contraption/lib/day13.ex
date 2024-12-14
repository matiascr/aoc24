defmodule Day13 do
  @moduledoc """
  Implementation of Advent of Code Day 13: Claw Contraption.

  [Advent of Code Day 13: Claw Contraption](https://adventofcode.com/2024/day/13)
  """

  @max_presses 100
  @a_cost 3
  @b_cost 1

  def parse_line(s, leading) do
    s
    |> String.trim()
    |> String.trim_leading(leading <> ": X")
    |> String.split(", Y")
    |> Enum.map(fn <<_::utf8, rest::binary>> -> rest end)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def parse_machine({a, b, prize}) do
    {parse_line(a, "Button A"), parse_line(b, "Button B"), parse_line(prize, "Prize")}
  end

  def find_prize(_claw_machine = {{ax, ay}, {bx, by}, {px, py}}) do
    det = ax * by - ay * bx
    a = (px * by - py * bx) |> div(det)
    b = (ax * py - ay * px) |> div(det)

    case {ax * a + bx * b, ay * a + by * b} do
      {^px, ^py} when a <= @max_presses and b <= @max_presses -> a * 3 + b
      _ -> 0
    end
  end

  def calc_presses({as, bs}) do
    as * @a_cost + bs * @b_cost
  end

  def part_1(data_path) do
    data_path
    |> File.stream!()
    |> Stream.chunk_every(3, 4)
    |> Stream.map(&List.to_tuple/1)
    |> Stream.map(&parse_machine/1)
    |> Stream.map(&find_prize/1)
    |> Enum.sum()
  end
end
