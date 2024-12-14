defmodule Day14 do
  def parse_robots(lines) do
    Stream.map(lines, fn line ->
      [px, py, vx, vy] =
        String.split(line)
        |> Stream.map(&String.split(&1, "="))
        |> Stream.map(&Enum.at(&1, 1))
        |> Stream.flat_map(&String.split(&1, ","))
        |> Stream.map(&String.to_integer/1)
        |> Enum.to_list()

      %{
        p: %{x: px, y: py},
        v: %{x: vx, y: vy}
      }
    end)
    |> Stream.with_index(&{&2, &1})
    |> Enum.into(%{})
  end

  def travel_coord(pos, vel, bound) do
    case pos + vel do
      new_pos when new_pos >= 0 and new_pos < bound -> new_pos
      new_pos when new_pos >= bound -> new_pos - bound
      new_pos when new_pos < 0 -> new_pos + bound
    end
  end

  def travel_robot(robots, robot_index, x_bound, y_bound) do
    %{
      p: %{x: px, y: py},
      v: %{x: vx, y: vy}
    } = robots[robot_index]

    new_x = travel_coord(px, vx, x_bound)
    new_y = travel_coord(py, vy, y_bound)

    Map.put(robots, robot_index, %{
      p: %{x: new_x, y: new_y},
      v: %{x: vx, y: vy}
    })
  end

  def travel(robots, _, _, 0), do: robots

  def travel(robots, x_bound, y_bound, iterations) do
    0..(map_size(robots) - 1)
    |> Enum.reduce(robots, fn robot_index, new_robots ->
      travel_robot(new_robots, robot_index, x_bound, y_bound)
    end)
    |> travel(x_bound, y_bound, iterations - 1)
  end

  def to_quadrants(robots, x_len, y_len) do
    x_middle = x_len |> div(2)
    y_middle = y_len |> div(2)

    left_half = 0..(x_middle - 1)
    right_half = (x_middle + 1)..(x_len - 1)
    top_half = 0..(y_middle - 1)
    bottom_half = (y_middle + 1)..(y_len - 1)

    quad1 = %{x: left_half, y: top_half}
    quad2 = %{x: right_half, y: top_half}
    quad3 = %{x: left_half, y: bottom_half}
    quad4 = %{x: right_half, y: bottom_half}

    Map.values(robots)
    |> Enum.group_by(fn %{p: %{x: px, y: py}} ->
      cond do
        px in quad1.x and py in quad1.y -> :quad1
        px in quad2.x and py in quad2.y -> :quad2
        px in quad3.x and py in quad3.y -> :quad3
        px in quad4.x and py in quad4.y -> :quad4
        true -> :omit
      end
    end)
    |> Map.delete(:omit)
    |> Map.values()
  end

  def part_1(data_path, x_len, y_len) do
    data_path
    |> File.stream!()
    |> parse_robots()
    |> travel(x_len, y_len, 100)
    |> to_quadrants(x_len, y_len)
    |> Enum.map(&length/1)
    |> Enum.product()
  end
end
