defmodule PhxEducationalDashboard.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxEducationalDashboardWeb.Telemetry,
      PhxEducationalDashboard.Repo,
      {DNSCluster,
       query: Application.get_env(:phx_educational_dashboard, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxEducationalDashboard.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxEducationalDashboard.Finch},
      # Start a worker by calling: PhxEducationalDashboard.Worker.start_link(arg)
      # {PhxEducationalDashboard.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxEducationalDashboardWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxEducationalDashboard.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxEducationalDashboardWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
