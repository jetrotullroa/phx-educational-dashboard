defmodule PhxEducationalDashboardWeb.StudentLive.Index do
  use PhxEducationalDashboardWeb, :live_view

  alias PhxEducationalDashboard.Accounts.Student
  alias PhxEducationalDashboard.Repo

  def mount(_params, _session, socket) do
    changeset = Student.changeset(%Student{}, %{})
    students = Repo.all(Student)

    {:ok,
     socket
     |> assign(:student_form, false)
     |> assign(:form, to_form(changeset))
     |> stream(:students, students)}
  end

  def render(assigns) do
    ~H"""
    <div id="students">
      <div class="row flex items-center justify-between">
        <div class="col-12">
          <h1 class="text-4xl text-accent font-semibold">Students</h1>
        </div>
        <div>
          <.button color="primary" label="Add Student" phx-click="show_form" />
        </div>
      </div>
      <div :if={@student_form} class="w-full my-4 p-4 bg-teal-400">
        <.form for={@form} phx-submit="on_submit">
          <div class="grid grid-cols-7 gap-4 w-full">
            <div class="col-span-6 w-full">
              <.field type="hidden" name="id" field={@form[:id]} />
              <.field
                label="Student Name"
                name="name"
                placeholder="Name of the student"
                field={@form[:name]}
                class="w-full bg-stone-100 text-gray-900"
              />
            </div>
            <div class="col-span-1 w-full">
              <.field
                label="Year"
                name="year"
                type="number"
                placeholder="Year Level"
                value={1}
                field={@form[:year]}
                class="w-full bg-stone-100 text-gray-900"
              />
            </div>
          </div>
          <div class="flex justify-end mt-4">
            <.button color="danger" label="Cancel" class="mr-4" phx-click="hide_form" />
            <.button color="primary" label="Save" type="submit" />
          </div>
        </.form>
      </div>
      <div>
        <.table class="w-100 mt-8">
          <.tr>
            <.th colspan="3">Student Name</.th>
            <.th colspan="2">Year</.th>
            <.th colspan="1" class="text-right"></.th>
          </.tr>
          <div id="students-list" phx-update="stream">
            <.tr
              :for={{student_id, student} <- @streams.students}
              :if={!empty_student_list(@streams.students)}
              id={student_id}
            >
              <.td colspan="3"><%= student.name %></.td>
              <.td colspan="2"><%= student.year %></.td>
              <.td colspan="1" class="text-right">
                <.button color="primary" label="Edit" phx-click="show_form" phx-value-id={student.id} />
                <.button color="danger" label="Delete" />
              </.td>
            </.tr>
            <.tr :if={empty_student_list(@streams.students)}>
              <.td colspan="6" class="text-center">No students found. Please create a new one.</.td>
            </.tr>
          </div>
        </.table>
      </div>
    </div>
    """
  end

  def handle_event("show_form", %{"id" => id}, socket) do
    student = Repo.get(Student, id)
    changeset = Student.changeset(student, %{})

    {:noreply,
     assign(socket, :student_form, true)
     |> assign(:form, to_form(changeset))}
  end

  def handle_event("show_form", _, socket) do
    {:noreply, assign(socket, :student_form, true)}
  end

  def handle_event("hide_form", _, socket) do
    changeset = Student.changeset(%Student{}, %{})
    {:noreply, socket |> assign(form: to_form(changeset)) |> assign(student_form: false)}
  end

  def handle_event("on_submit", %{"id" => student_id} = student_params, socket) do
    changeset = Student.changeset(%Student{}, student_params)

    case Repo.insert_or_update(changeset) do
      {:ok, student} ->
        at = if student_id != nil, do: student_id, else: -1

        {:noreply,
         socket
         |> stream_insert(:students, student, at: at)
         |> assign(:form, to_form(Student.changeset(%Student{}, %{})))
         |> assign(:student_form, false)}

      {:error, changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end

  defp empty_student_list(students), do: students == []
end
