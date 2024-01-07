defmodule PhxEducationalDashboardWeb.DashboardLive.Index do
  use PhxEducationalDashboardWeb, :live_view

  @impl true
  def mount(params, session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>Dashboard</div>
    """
  end
end
