defmodule Peredacha.Utils do
  def get_api_url(opts) do
    api_url_base = get_api_url()
    api_suffix = Keyword.get(opts, :url, "")
    api_url_base <> api_suffix <> "/graphql"
  end

  def get_api_url(), do: Application.get_env(:peredacha, :api_url_base)
  def get_store_secret(), do: Application.get_env(:peredacha, :store_secret)
  def get_store_slug(), do: Application.get_env(:peredacha, :store_slug)
end
