defmodule Oppcis.Repo.Migrations.AddFieldsToItems do
  use Ecto.Migration

  def change do
    alter table(:items) do
      add :category, :string
    end
  end
end
