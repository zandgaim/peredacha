defmodule Peredacha.TokenStorage do
  use GenServer
  require Logger

  alias Peredacha.CoreApiClient

  @name __MODULE__
  @margin 30

  # Client API

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{token: nil, exp: nil}, name: @name)
  end

  def get_token do
    GenServer.call(@name, :get_token)
  end

  # Server Callbacks

  @impl true
  def init(state) do
    Logger.info("[AppToken] starting token server")
    {:ok, state, {:continue, :fetch_initial_token}}
  end

  @impl true
  def handle_continue(:fetch_initial_token, state) do
    {:noreply, perform_fetch(state)}
  end

  @impl true
  def handle_call(:get_token, _from, %{token: token} = state) when is_binary(token) do
    {:reply, token, state}
  end

  @impl true
  def handle_call(:get_token, _from, state) do
    case fetch_token() do
      {:ok, %{"token" => token, "exp" => exp}} ->
        schedule_refresh(exp)
        {:reply, token, %{token: token, exp: exp}}

      {:error, reason} ->
        {:reply, {:error, reason}, state}
    end
  end

  @impl true
  def handle_info(:refresh_token, state) do
    Logger.info("[AppToken] refreshing app token")
    {:noreply, perform_fetch(state)}
  end

  defp perform_fetch(state) do
    case fetch_token() do
      {:ok, %{"token" => token, "exp" => exp} = response} ->
        schedule_refresh(exp)
        %{token: token, exp: exp}

      {:error, reason} ->
        Logger.error("[AppToken] fetch failed: #{inspect(reason)}")
        Process.send_after(self(), :refresh_token, 10_000)
        state
    end
  end

  defp fetch_token do
    CoreApiClient.fetch_app_token()
  end

  defp schedule_refresh(exp_unix) do
    now = System.system_time(:second)
    refresh_in = max((exp_unix - now - @margin) * 1_000, 1_000)
    Process.send_after(self(), :refresh_token, refresh_in)
  end
end
