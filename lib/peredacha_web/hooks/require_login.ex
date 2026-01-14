defmodule PeredachaWeb.Hooks.RequireLogin do
  import Phoenix.LiveView
  import Phoenix.Component

  alias Peredacha.CoreApiClient

  use PeredachaWeb, :verified_routes

  def on_mount(:ensure_authenticated, _params, session, socket) do

    case session["access_token"] do
      token when is_binary(token) ->
        case CoreApiClient.get_user_by_token(token) do
          {:ok, user} -> {:cont, assign(socket, :current_user, user)}
          {:error, _reason} -> {:halt, redirect_to_refresh(socket)}
        end

      _ ->
        {:halt, redirect_to_auth(socket)}
    end
  end

  def on_mount(:redirect_if_authenticated, _params, session, socket) do
    case session["access_token"] do
      token when is_binary(token) ->
        {:halt, redirect(socket, to: "/")}

      _ ->
        {:cont, socket}
    end
  end

  defp redirect_to_auth(socket) do
    socket
    |> put_flash(:error, "Будь ласка, увійдіть у систему")
    |> redirect(to: ~p"/auth")
  end

  defp redirect_to_refresh(socket) do
    socket
    |> redirect(to: "/auth/refresh")
  end
end
