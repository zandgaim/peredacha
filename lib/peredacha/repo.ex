defmodule Peredacha.Repo do
  use Ecto.Repo,
    otp_app: :peredacha,
    adapter: Ecto.Adapters.Postgres
end
