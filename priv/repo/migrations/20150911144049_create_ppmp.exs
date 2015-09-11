defmodule Oppcis.Repo.Migrations.CreatePPMP do
  use Ecto.Migration

  def change do
    create table(:ppmps) do
      add :code, :string
      add :status, :string
      add :year, :string

      timestamps
    end

  end
end
