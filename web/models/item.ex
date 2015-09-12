defmodule Oppcis.Item do
  use Oppcis.Web, :model

  schema "items" do
    field :project, :string
    field :description, :string
    field :estimated_budget, :integer
    field :funding, :string
    field :procurement_mode, :string
    field :procurement_type, :string
    field :contract_type, :string
    field :quantity, :integer
    field :unit, :string
    
    belongs_to :ppmp, Oppcis.Ppmp
    timestamps
  end

  @required_fields ~w(project description estimated_budget funding procurement_mode procurement_type contract_type quantity unit)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
