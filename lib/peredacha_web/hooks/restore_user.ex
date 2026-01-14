# lib/peredacha_web/hooks/restore_user.ex
defmodule PeredachaWeb.Hooks.RestoreUser do
  import Phoenix.LiveView
  import Phoenix.Component
  alias Peredacha.CoreApiClient

  def on_mount(:default, _params, session, socket) do
    # assign_new шукає :current_user в conn.assigns (які підготував Плаг)
    # Якщо знаходить — API НЕ викликається вдруге.
    socket = assign_new(socket, :current_user, fn ->
      case session["access_token"] do
        token when is_binary(token) ->
          case CoreApiClient.get_user_by_token(token) do
            {:ok, user} -> user
            _ -> nil
          end
        _ -> nil
      end
    end)

    {:cont, socket}
  end
end
