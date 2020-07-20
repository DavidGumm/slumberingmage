defmodule Deusexlog.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  @site_name "DeusExLog"
  def site_name_data, do: @site_name

  use Application
  require Logger

  def start(_type, _args) do
    Logger.info("Starting Application #{@site_name}")
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      Deusexlog.Repo,
      # Start the endpoint when the application starts
      DeusexlogWeb.Endpoint
      # Starts a worker by calling: Deusexlog.Worker.start_link(arg)
      # {Deusexlog.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Deusexlog.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DeusexlogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
