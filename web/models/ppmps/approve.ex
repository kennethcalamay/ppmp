defmodule Oppcis.PPMP.Approve do
  use Oppcis.Web, :operation
  import Ecto.Query
  alias Oppcis.PPMP

  def process(%{"id" => id}) do
    ppmp = Repo.get!(PPMP, id)
    code = generate_code(ppmp)

    changeset = changeset(ppmp, %{status: "approved", code: code})
    Repo.update(changeset)
  end

  defp changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(status code), ~w())
  end

  defp generate_code(%PPMP{year: year}) do
    code = last_ppmp_code(year)
    cond do
      code in ["", nil] ->
        year <> "-" <> "1"
      true ->
        [^year, num] = String.split(code, "-")
        incremented  = String.to_integer(num) + 1
        year <> "-" <> Integer.to_string(incremented)
    end
  end

  defp last_ppmp_code(year) do
    Repo.one from p in PPMP, where: p.year == ^year, order_by: p.code, select: p.code, limit: 1
  end

end
