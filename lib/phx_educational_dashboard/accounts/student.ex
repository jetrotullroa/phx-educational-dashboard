defmodule PhxEducationalDashboard.Accounts.Student do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "students" do
    field :name, :string
    field :year, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:name, :year])
    |> validate_required([:name, :year])
    |> unique_constraint(:name)
    |> validate_number(:year, greater_than_or_equal_to: 1, less_than_or_equal_to: 4)
  end
end
