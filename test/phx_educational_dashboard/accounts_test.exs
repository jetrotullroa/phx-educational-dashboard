defmodule PhxEducationalDashboard.AccountsTest do
  use PhxEducationalDashboard.DataCase

  alias PhxEducationalDashboard.Accounts

  describe "students" do
    alias PhxEducationalDashboard.Accounts.Student

    import PhxEducationalDashboard.AccountsFixtures

    @invalid_attrs %{name: nil, year: nil}

    test "list_students/0 returns all students" do
      student = student_fixture()
      assert Accounts.list_students() == [student]
    end

    test "get_student!/1 returns the student with given id" do
      student = student_fixture()
      assert Accounts.get_student!(student.id) == student
    end

    test "create_student/1 with valid data creates a student" do
      valid_attrs = %{name: "some name", year: 42}

      assert {:ok, %Student{} = student} = Accounts.create_student(valid_attrs)
      assert student.name == "some name"
      assert student.year == 42
    end

    test "create_student/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_student(@invalid_attrs)
    end

    test "update_student/2 with valid data updates the student" do
      student = student_fixture()
      update_attrs = %{name: "some updated name", year: 43}

      assert {:ok, %Student{} = student} = Accounts.update_student(student, update_attrs)
      assert student.name == "some updated name"
      assert student.year == 43
    end

    test "update_student/2 with invalid data returns error changeset" do
      student = student_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_student(student, @invalid_attrs)
      assert student == Accounts.get_student!(student.id)
    end

    test "delete_student/1 deletes the student" do
      student = student_fixture()
      assert {:ok, %Student{}} = Accounts.delete_student(student)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_student!(student.id) end
    end

    test "change_student/1 returns a student changeset" do
      student = student_fixture()
      assert %Ecto.Changeset{} = Accounts.change_student(student)
    end
  end
end
