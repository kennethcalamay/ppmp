defmodule Oppcis.ItemController do
  use Oppcis.Web, :controller

  plug :scrub_params, "item" when action in [:create]

  def create(conn, params) do
    flash = case Oppcis.Item.Create.process(params) do
      {:ok,    _item}     -> put_flash(conn, :info, "Item created successfully.")
      {:error, changeset} -> put_flash(conn, :error, changeset.errors)
    end

    redirect(flash, to: ppmp_path(conn, :show, params["ppmp_id"]))
  end

end
