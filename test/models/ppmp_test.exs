defmodule Oppcis.PPMPTest do
  use Oppcis.ModelCase

  alias Oppcis.PPMP

  @valid_attrs %{code: "some content", status: "some content", year: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PPMP.changeset(%PPMP{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PPMP.changeset(%PPMP{}, @invalid_attrs)
    refute changeset.valid?
  end
end
