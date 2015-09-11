defmodule Oppcis.PPMP.Create do
  use Oppcis.Web, :operation

  @required_fields ~w(year)
  @optional_fields ~w(status)

  def changeset(model, params \\ :empty) do
    model
    |> cast(bind_defaults(params), @required_fields, @optional_fields)
  end

  defp bind_defaults(params) do
    case params do
      :empty -> params
      %{ "year" => year } -> %{ "year" => year, "status" => "draft" }
    end
  end

end
