defmodule Oppcis.PPMP.Approve do
  use Oppcis.Web, :operation

  alias Oppcis.PPMP

  @required_fields ~w(year status)
  @optional_fields ~w(code)

  def process(%{"id" => id, "ppmp" => ppmp_params}) do
    ppmp      = Repo.get!(PPMP, id)
    changeset = changeset(ppmp, ppmp_params)
    Repo.update(changeset)
  end

  # private

  defp changeset(model, params \\ :empty) do
    model
    |> cast(assign_code(params), @required_fields, @optional_fields)
  end

  defp assign_code(params) do
    case params do
      :empty  -> params
      _params -> Map.put(params, "code", generate_code(params))
    end
  end

  defp generate_code(params) do
    %{ "year" => year } = params
    year <> "-tail"
  end
end
