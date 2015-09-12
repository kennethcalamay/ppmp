defmodule Oppcis.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :project, :string
      add :description, :string
      add :estimated_budget, :integer
      add :funding, :string
      add :procurement_mode, :string
      add :procurement_type, :string
      add :contract_type, :string
      add :quantity, :integer
      add :unit, :string
      add :ppmp_id, references(:ppmps)

      timestamps
    end
    create index(:items, [:ppmp_id])

  end
end
