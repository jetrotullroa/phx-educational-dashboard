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
     |> assign(:students, students)}
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
            <.th colspan="1">Year</.th>
            <.th colspan="2" class="text-right"></.th>
          </.tr>
          <div :if={@students !== []}>
            <.tr :for={student <- @students}>
              <.td colspan="3"><%= student.name %></.td>
              <.td colspan="1"><%= student.year %></.td>
              <.td colspan="2" class="text-right">
                <.button color="primary" label="Edit" />
                <.button color="danger" label="Delete" />
              </.td>
            </.tr>
          </div>
        </.table>
      </div>
    </div>
    """
  end

  def handle_event("show_form", _, socket) do
    {:noreply, assign(socket, :student_form, true)}
  end

  def handle_event("hide_form", _, socket) do
    {:noreply, assign(socket, :student_form, false)}
  end

  def handle_event("on_submit", student_params, socket) do
    changeset = Student.changeset(%Student{}, student_params)

    case Repo.insert(changeset) do
      {:ok, _student} ->
        {:noreply, assign(socket, :student_form, false)}

      {:error, changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end
