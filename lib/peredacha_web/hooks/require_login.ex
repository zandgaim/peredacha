defmodule PeredachaWeb.Hooks.RequireLogin do
  import Phoenix.LiveView
  use PeredachaWeb, :verified_routes

  def on_mount(:ensure_authenticated, _params, session, socket) do
    cond do
      not connected?(socket) ->
        if session["access_token"] do
          {:cont, socket}
        else
          {:halt, redirect_to_auth(socket)}
        end

      socket.assigns[:current_user] == :token_expired ->
        {:halt, redirect_to_refresh(socket)}

      socket.assigns[:current_user] ->
        {:cont, socket}

      true ->
        {:halt, redirect_to_auth(socket)}
    end
  end

  def on_mount(:redirect_if_authenticated, _params, _session, socket) do
    cond do
      not connected?(socket) ->
        {:cont, socket}

      is_map(socket.assigns[:current_user]) ->
        {:halt, redirect(socket, to: "/")}

      true ->
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
