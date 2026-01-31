defmodule PeredachaWeb.Hooks.RestoreUser do
  import Phoenix.Component
  alias Peredacha.CoreApiClient

  def on_mount(:default, _params, session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        fetch_user(session["access_token"])
      end)

    {:cont, socket}
  end

  defp fetch_user(token) when is_binary(token) do
    case CoreApiClient.get_user_by_token(token) do
      {:ok, user} -> user
      {:error, _} -> :token_expired
    end
  end

  defp fetch_user(_), do: nil
end
