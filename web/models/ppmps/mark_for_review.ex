defmodule Oppcis.PPMP.MarkForReview do
  use Oppcis.Web, :operation

  alias Oppcis.PPMP

  def process(%{"id" => id}) do
    ppmp = Repo.get!(PPMP, id)
    Repo.update(changeset(ppmp, %{}))
  end

  defp changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(status), [])
  end
end
