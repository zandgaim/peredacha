defmodule PeredachaWeb.Plugs.SetLocale do
  import Plug.Conn

  @default_locale "uk"
  @locales ["en", "uk"]

  def init(opts), do: opts

  def call(conn, _opts) do
    locale =
      Map.get(conn.params, "lang") ||
        get_session(conn, :locale) ||
        @default_locale

    locale = if locale in @locales, do: locale, else: @default_locale

    Gettext.put_locale(PeredachaWeb.Gettext, locale)
    put_session(conn, :locale, locale)
  end
end
