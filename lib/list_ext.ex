defmodule ListExt do
  def is_subsequence(_, []), do: true
  def is_subsequence([], _), do: false
  def is_subsequence(list, sequence), do: is_subsequence(list, sequence, false)

  defp is_subsequence([], [_|_], _), do: false
  defp is_subsequence([h|_], [h], true), do: true
  defp is_subsequence([h|rest], [h|subrest], _), do: is_subsequence(rest, subrest, true)
  defp is_subsequence([_|rest], [_|_] = sequence, _), do: is_subsequence(rest, sequence, false)
end
