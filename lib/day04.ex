defmodule Day04 do
  @input 357_253..892_942

  def part1 do
    @input
    |> Stream.map(&Integer.digits/1)
    |> Stream.filter(&match_criteria_part1?/1)
    |> Enum.count()
  end

  def part2 do
    @input
    |> Stream.map(&Integer.digits/1)
    |> Stream.filter(&match_criteria_part2?/1)
    |> Enum.count()
  end

  def match_criteria_part1?(digits) do
    has_repeated?(digits) && never_decrease?(digits)
  end

  def match_criteria_part2?(digits) do
    has_repeated_part2(digits) && never_decrease?(digits)
  end

  @doc """
  iex> Day04.has_repeated?([1, 3, 4, 5])
  false

  iex> Day04.has_repeated?([1, 2, 3, 3])
  true

  iex> Day04.has_repeated?([1, 2, 2, 2])
  true

  iex> Day04.has_repeated?([1, 1, 1, 1, 2, 2])
  true
  """
  def has_repeated?([]), do: false
  def has_repeated?([h | [h | _t]]), do: true
  def has_repeated?([_ | t]), do: has_repeated?(t)

  @doc """
  iex> Day04.has_repeated_part2([1, 2, 2, 2])
  false

  iex> Day04.has_repeated_part2([1, 1, 1, 1, 2, 2])
  true
  """
  def has_repeated_part2([]), do: false
  def has_repeated_part2([h | [h | [h | [h | [h | t]]]]]), do: has_repeated_part2(t)
  def has_repeated_part2([h | [h | [h | [h | t]]]]), do: has_repeated_part2(t)
  def has_repeated_part2([h | [h | [h | t]]]), do: has_repeated_part2(t)
  def has_repeated_part2([h | [h | _t]]), do: true
  def has_repeated_part2([_ | t]), do: has_repeated_part2(t)

  @doc """
  iex> Day04.never_decrease?([1, 2, 3, 4, 5])
  true

  iex> Day04.never_decrease?([1, 1, 1, 1])
  true

  iex> Day04.never_decrease?([2, 3, 2])
  false
  """
  def never_decrease?([]), do: true
  def never_decrease?([h | [h2 | _]]) when h > h2, do: false
  def never_decrease?([_ | t]), do: never_decrease?(t)
end
