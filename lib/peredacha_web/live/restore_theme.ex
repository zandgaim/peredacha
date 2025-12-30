defmodule PeredachaWeb.Live.RestoreTheme do
  import Phoenix.Component

  def on_mount(:default, _params, session, socket) do
    theme = session["theme"] || "system"
    {:cont, assign(socket, :theme, theme)}
  end
end
