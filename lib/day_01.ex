defmodule Day01 do
  def part1 do
    File.read!("priv/day01_1.txt")
    |> String.split()
    |> calculate()
    |> Enum.sum()
  end

  def part2 do
    File.read!("priv/day01_1.txt")
    |> String.split()
    |> calculate2()
    |> Enum.sum()
  end

  def calculate(numbers) do
    numbers
    |> Enum.map(fn input ->
      {number, _rest} = Integer.parse(input)
      floor(number / 3) - 2
    end)
  end

  def calculate2(fuels) do
    fuels
    |> Enum.map(fn input ->
      {number, _rest} = Integer.parse(input)
      calculate2(number, 0)
    end)
  end

  def calculate2(fuel, acc) when fuel > 0 do
    required = div(fuel, 3) - 2
    calculate2(required, acc + required)
  end

  def calculate2(fuel, acc) do
    acc
  end

  def total_fuel(mass) do
    case fuel(mass) do
      needed when needed > 0 ->
        needed + total_fuel(needed)

      _ ->
        0
    end
  end

  def fuel(mass) do
    div(mass, 3) - 2
  end
end
