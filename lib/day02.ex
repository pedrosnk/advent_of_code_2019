defmodule Day02 do
  @input File.read!("priv/day02.txt")
         |> String.trim()
         |> String.split(",")
         |> Enum.map(&String.to_integer/1)

  def part1 do
    @input
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> compute()
    |> hd()
  end

  def part2 do
    {noun, verb, _} =
      for(noun <- 0..99, verb <- 0..99) do
        computed =
          @input
          |> List.replace_at(1, noun)
          |> List.replace_at(2, verb)
          |> compute()

        {noun, verb, computed}
      end
      |> Enum.find(fn {_, _, computed} ->
        computed |> hd() == 19_690_720
      end)

    100 * noun + verb
  end

  @doc """
    Compute Advent of Code 2019 day 2 challange

      iex> Day02.compute([1, 0, 0, 0, 99])
      [2, 0, 0, 0, 99]

      iex> Day02.compute([2, 3, 0, 3, 99])
      [2, 3, 0, 6, 99]

      iex> Day02.compute([1, 1, 1, 4, 99, 5, 6, 0, 99])
      [30, 1, 1, 4, 2, 5, 6, 0, 99]
  """
  def compute(input, pos \\ 0) do
    case Enum.at(input, pos) do
      1 ->
        value1 = Enum.at(input, Enum.at(input, pos + 1))
        value2 = Enum.at(input, Enum.at(input, pos + 2))
        replace = Enum.at(input, pos + 3)
        compute(List.replace_at(input, replace, value1 + value2), pos + 4)

      2 ->
        value1 = Enum.at(input, Enum.at(input, pos + 1))
        value2 = Enum.at(input, Enum.at(input, pos + 2))
        replace = Enum.at(input, pos + 3)
        compute(List.replace_at(input, replace, value1 * value2), pos + 4)

      99 ->
        input
    end
  end
end
