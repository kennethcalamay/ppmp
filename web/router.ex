defmodule Oppcis.Router do
  use Oppcis.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Oppcis do
    pipe_through :browser # Use the default browser stack

    get "/", PPMPController, :index, as: :root
    resources "/ppmps", PPMPController do
      resources "/items", ItemController
    end
    patch "ppmps/:id/mark_for_review", PPMPController, :mark_for_review
    patch "ppmps/:id/approve", PPMPController, :approve
  end

  # Other scopes may use custom stacks.
  # scope "/api", Oppcis do
  #   pipe_through :api
  # end
end
