defmodule Day03 do
  @input File.read!("priv/day03.txt")
         |> String.trim()
         |> String.split("\n")
         |> Enum.map(fn value ->
           value |> String.split(",")
         end)

  def part1 do
    [wire1, wire2] =
      wires()
      |> Enum.map(&wireup/1)
      |> Enum.map(&MapSet.new/1)

    MapSet.intersection(wire1, wire2)
    |> MapSet.delete({0, 0})
    |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.min()
  end

  def part2 do
    [wire1, wire2] =
      wires()
      |> Enum.map(&wireup/1)

    map1 = MapSet.new(wire1)
    map2 = MapSet.new(wire2)

    MapSet.intersection(wire1, wire2)
    |> MapSet.delete({0, 0})
    |> Enum.map(fn pos ->
      count1 = Enum.find_index(wire1, fn p -> p == pos end)
      count2 = Enum.find_index(wire2, fn p -> p == pos end)
      count1 + count2
    end)
  end

  def wires() do
    @input
    |> Enum.map(fn wire ->
      Enum.map(wire, fn
        "U" <> distance -> {:up, String.to_integer(distance)}
        "D" <> distance -> {:down, String.to_integer(distance)}
        "R" <> distance -> {:right, String.to_integer(distance)}
        "L" <> distance -> {:left, String.to_integer(distance)}
      end)
    end)
  end

  def wireup(wire, acc \\ [{0, 0}])
  def wireup([], acc), do: acc
  def wireup([{_, 0} | tail], acc), do: wireup(tail, acc)

  def wireup([movement | tail], [pos | _] = acc) do
    {orientation, distance} = movement
    wireup([{orientation, distance - 1} | tail], [move(orientation, pos) | acc])
  end

  def move(:up, {x, y}), do: {x, y + 1}
  def move(:down, {x, y}), do: {x, y - 1}
  def move(:right, {x, y}), do: {x + 1, y}
  def move(:left, {x, y}), do: {x - 1, y}
end
