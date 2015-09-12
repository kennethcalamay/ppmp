defmodule Oppcis.ItemTest do
  use Oppcis.ModelCase

  alias Oppcis.Item

  @valid_attrs %{contract_type: "some content", description: "some content", estimated_budget: 42, funding: "some content", procurement_mode: "some content", procurement_type: "some content", project: "some content", quantity: 42, unit: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Item.changeset(%Item{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Item.changeset(%Item{}, @invalid_attrs)
    refute changeset.valid?
  end
end
