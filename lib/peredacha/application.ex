defmodule Peredacha.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [
        PeredachaWeb.Telemetry,
        {DNSCluster, query: Application.get_env(:peredacha, :dns_cluster_query) || :ignore},
        {Phoenix.PubSub, name: Peredacha.PubSub},
        # Start a worker by calling: Peredacha.Worker.start_link(arg)
        # {Peredacha.Worker, arg},
        # Start to serve requests, typically the last entry
        PeredachaWeb.Endpoint
      ]
      |> maybe_add_repo()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Peredacha.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PeredachaWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp maybe_add_repo(children) do
    # if System.get_env("DISABLE_DB") == "true" do
    IO.puts(">>> DISABLE_DB=true — not starting Repo")
    children
    # else
    #   [Peredacha.Repo | children]
    # end
  end
end
