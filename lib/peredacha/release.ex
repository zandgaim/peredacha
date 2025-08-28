defmodule Peredacha.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  @app :peredacha

  def migrate do
    if db_disabled?() do
      IO.puts(">>> DISABLE_DB=true — skipping migrations")
    else
      load_app()

      for repo <- repos() do
        {:ok, _, _} =
          Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
      end
    end
  end

  def rollback(repo, version) do
    if db_disabled?() do
      IO.puts(">>> DISABLE_DB=true — skipping rollback")
    else
      load_app()

      {:ok, _, _} =
        Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
    end
  end

  defp repos do
    Application.get_env(@app, :ecto_repos, [])
  end

  defp load_app do
    # Many platforms require SSL when connecting to the database
    Application.ensure_all_started(:ssl)
    Application.ensure_loaded(@app)
  end

  defp db_disabled? do
    System.get_env("DISABLE_DB") == "true"
  end
end
