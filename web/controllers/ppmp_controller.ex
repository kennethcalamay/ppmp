defmodule Oppcis.PPMPController do
  use Oppcis.Web, :controller

  alias Oppcis.PPMP
  alias Oppcis.Item

  plug :scrub_params, "ppmp" when action in [:create, :update]

  def index(conn, _params) do
    ppmps = Repo.all(PPMP)
    render(conn, "index.html", ppmps: ppmps)
  end

  def new(conn, _params) do
    changeset = PPMP.Create.changeset(%PPMP{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ppmp" => ppmp_params}) do
    changeset = PPMP.Create.changeset(%PPMP{}, ppmp_params)

    case Repo.insert(changeset) do
      {:ok, _ppmp} ->
        conn
        |> put_flash(:info, "Ppmp created successfully.")
        |> redirect(to: ppmp_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ppmp = Repo.get!(PPMP, id) |> Repo.preload(:items)

    item_changeset = Item.changeset(%Item{})

    render(conn, "show.html", ppmp: ppmp, item_changeset: item_changeset)
  end

  def edit(conn, %{"id" => id}) do
    ppmp = Repo.get!(PPMP, id)
    changeset = PPMP.changeset(ppmp)
    render(conn, "edit.html", ppmp: ppmp, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ppmp" => ppmp_params}) do
    ppmp = Repo.get!(PPMP, id)
    changeset = PPMP.changeset(ppmp, ppmp_params)

    case Repo.update(changeset) do
      {:ok, ppmp} ->
        conn
        |> put_flash(:info, "Ppmp updated successfully.")
        |> redirect(to: ppmp_path(conn, :show, ppmp))
      {:error, changeset} ->
        render(conn, "edit.html", ppmp: ppmp, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ppmp = Repo.get!(PPMP, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(ppmp)

    conn
    |> put_flash(:info, "Ppmp deleted successfully.")
    |> redirect(to: ppmp_path(conn, :index))
  end

  def mark_for_review(conn, params) do
    ppmp = Repo.get!(PPMP, params["id"])
    changeset = PPMP.changeset(ppmp, %{"status" => "for nep review"})

    case Repo.update(changeset) do
      {:ok, _ppmp} ->
        conn
        |> put_flash(:info, "Marked for review")
        |> redirect(to: ppmp_path(conn, :index))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Mark for review failed")
        |> redirect(to: ppmp_path(conn, :index))
    end
  end

  def approve(conn, params) do
    case PPMP.Approve.process(params) do
      {:ok, _ppmp} ->
        conn
        |> put_flash(:info, "PPMP updated successfully.")
        |> redirect(to: ppmp_path(conn, :index))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "PPMP was not updated.")
        |> redirect(to: ppmp_path(conn, :index))
    end

  end
end
