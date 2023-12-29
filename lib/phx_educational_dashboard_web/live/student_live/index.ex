defmodule PhxEducationalDashboardWeb.StudentLive.Index do
  use PhxEducationalDashboardWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="container">
      <div class="row">
        <div class="col-12">
          <h1>Student Live</h1>
        </div>
      </div>
    </div>
    """
  end
end
