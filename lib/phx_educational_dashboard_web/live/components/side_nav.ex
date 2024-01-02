defmodule PhxEducationalDashboardWeb.Components.SideNav do
  use PhxEducationalDashboardWeb, :live_component

  def mount(socket) do
    {:ok, assign(socket, :selected_page, get_selected_menu(socket.view))}
  end

  def render(assigns) do
    ~H"""
    <div class="w-96">
      <.vertical_menu
        current_page={@selected_page}
        menu_items={[
          %{
            name: :dashboard,
            label: "Dashboard",
            path: ~p"/dashboard",
            icon: :home
          },
          %{
            name: :students,
            label: "Students",
            path: ~p"/students",
            icon: :academic_cap
          }
        ]}
      />
    </div>
    """
  end

  defp get_selected_menu(module) do
    case module do
      PhxEducationalDashboardWeb.StudentLive.Index -> :students
      PhxEducationalDashboardWeb.DashboardLive.Index -> :dashboard
      _ -> :dashboard
    end
  end
end
