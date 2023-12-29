defmodule PhxEducationalDashboard.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhxEducationalDashboard.Accounts` context.
  """

  @doc """
  Generate a student.
  """
  def student_fixture(attrs \\ %{}) do
    {:ok, student} =
      attrs
      |> Enum.into(%{
        name: "some name",
        year: 42
      })
      |> PhxEducationalDashboard.Accounts.create_student()

    student
  end
end
