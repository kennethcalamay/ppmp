defmodule Oppcis.PPMPControllerTest do
  use Oppcis.ConnCase

  alias Oppcis.PPMP
  @valid_attrs %{code: "some content", status: "some content", year: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, ppmp_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing ppmps"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, ppmp_path(conn, :new)
    assert html_response(conn, 200) =~ "New ppmp"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, ppmp_path(conn, :create), ppmp: @valid_attrs
    assert redirected_to(conn) == ppmp_path(conn, :index)
    assert Repo.get_by(PPMP, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, ppmp_path(conn, :create), ppmp: @invalid_attrs
    assert html_response(conn, 200) =~ "New ppmp"
  end

  test "shows chosen resource", %{conn: conn} do
    ppmp = Repo.insert! %PPMP{}
    conn = get conn, ppmp_path(conn, :show, ppmp)
    assert html_response(conn, 200) =~ "Show ppmp"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, ppmp_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    ppmp = Repo.insert! %PPMP{}
    conn = get conn, ppmp_path(conn, :edit, ppmp)
    assert html_response(conn, 200) =~ "Edit ppmp"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    ppmp = Repo.insert! %PPMP{}
    conn = put conn, ppmp_path(conn, :update, ppmp), ppmp: @valid_attrs
    assert redirected_to(conn) == ppmp_path(conn, :show, ppmp)
    assert Repo.get_by(PPMP, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    ppmp = Repo.insert! %PPMP{}
    conn = put conn, ppmp_path(conn, :update, ppmp), ppmp: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit ppmp"
  end

  test "deletes chosen resource", %{conn: conn} do
    ppmp = Repo.insert! %PPMP{}
    conn = delete conn, ppmp_path(conn, :delete, ppmp)
    assert redirected_to(conn) == ppmp_path(conn, :index)
    refute Repo.get(PPMP, ppmp.id)
  end
end
