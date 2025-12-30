defmodule PeredachaWeb.Plugs.ThemePlug do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    # 1. Read the cookie (default to "system" or "light")
    theme = conn.cookies["theme"] || "system"

    conn
    # 2. Store it in the Session (Critical for app.html.heex access)
    |> put_session("theme", theme)
    # 3. Store in assigns (for root.html.heex access)
    |> assign(:theme, theme)
  end
end
