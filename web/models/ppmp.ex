defmodule Oppcis.PPMP do
  use Oppcis.Web, :model

  schema "ppmps" do
    field :code, :string
    field :status, :string
    field :year, :string

    has_many :items, Oppcis.Item
    timestamps
  end

  @required_fields ~w(status year)
  @optional_fields ~w(code)

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
