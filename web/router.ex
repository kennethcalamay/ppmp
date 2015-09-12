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
      patch "/approve", PPMPController, :approve, as: :approve
      resources "/items", ItemController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Oppcis do
  #   pipe_through :api
  # end
end
