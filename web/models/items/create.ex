defmodule Oppcis.Item.Create do
  use Oppcis.Web, :operation

  alias Oppcis.PPMP
  alias Oppcis.Item

  @required_fields ~w(project category description procurement_mode procurement_type contract_type estimated_budget funding unit ppmp_id)
  @optional_fields ~w(quantity)

  def process(params) do
    ppmp = Repo.get(PPMP, params["ppmp_id"])
    item = Repo.build(ppmp, :items, params["items"])

    changeset = changeset(%Item{}, item)

    case Repo.insert(changeset) do
      {:ok, model} -> {:ok, model}
      {:error, changeset} -> {:error, changeset}
    end
  end

  defp extract_item(params) do
    Map.put(params["item"], "ppmp_id", params["ppmp_id"])
  end

  defp changeset(model, params \\ :empty, ppmp_id) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
