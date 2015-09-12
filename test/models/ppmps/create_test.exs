defmodule Oppcis.PPMP.CreateTest do
  use Oppcis.ModelCase

  alias Oppcis.PPMP

  @valid_attrs %{"year" => "2015"}
  @invalid_attrs :empty

  test "changeset with valid attributes" do
    changeset = PPMP.Create.changeset(%PPMP{}, @valid_attrs)
    assert changeset.valid?
  end

  test "it cannot be created without a year" do
    changeset = PPMP.Create.changeset(%PPMP{}, @invalid_attrs)
    refute changeset.valid?
  end
end
