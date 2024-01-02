defmodule PhxEducationalDashboardWeb.StudentLive.Index do
  use PhxEducationalDashboardWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div id="students">
      <div class="row flex items-center justify-between">
        <div class="col-12">
          <h1 class="text-4xl text-accent font-semibold">Students</h1>
        </div>
        <div>
          <.button color="primary" label="Add Student" />
        </div>
      </div>
    </div>
    """
  end
end
