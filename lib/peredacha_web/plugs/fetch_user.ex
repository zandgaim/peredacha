# lib/peredacha_web/plugs/fetch_user.ex
defmodule PeredachaWeb.Plugs.FetchUser do
  import Plug.Conn
  alias Peredacha.CoreApiClient

  def init(opts), do: opts

  def call(conn, _opts) do
    access_token = get_session(conn, :access_token)

    if access_token && is_nil(conn.assigns[:current_user]) do
      case CoreApiClient.get_user_by_token(access_token) do
        {:ok, user} -> assign(conn, :current_user, user)
        {:error, _} -> assign(conn, :current_user, nil)
      end
    else
      assign(conn, :current_user, nil)
    end
  end
end
