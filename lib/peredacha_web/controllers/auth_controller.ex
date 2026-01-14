defmodule PeredachaWeb.AuthController do
  use PeredachaWeb, :controller

  alias Peredacha.CoreApiClient

  def login_success(conn, %{"access_token" => at, "refresh_token" => rt}) do
    conn
    |> put_session(:access_token, at)
    |> put_session(:refresh_token, rt)
    |> configure_session(renew: true)
    |> redirect(to: "/")
  end

  def logout(conn, _params) do
    access_token = get_session(conn, :access_token)
    refresh_token = get_session(conn, :refresh_token)

    # 1. Спроба відкликати токен на бекенді
    if access_token && refresh_token do
      # Ми не чекаємо на успіх (spawn), щоб логаут не "висів",
      # якщо бекенд раптом недоступний.
      Task.start(fn -> CoreApiClient.logout(access_token, refresh_token) end)
    end

    # 2. Очищення локальної сесії
    conn
    |> clear_session()
    |> put_flash(:info, "Ви успішно вийшли з системи")
    |> redirect(to: "/")
  end

  def refresh(conn, _params) do
    # 1. Дістаємо старий refresh token із сесії
    old_refresh_token = get_session(conn, :refresh_token)

    # Зберігаємо шлях, куди користувач хотів потрапити (якщо передали)
    return_to = get_session(conn, :return_to) || "/dashboard"

    case CoreApiClient.refresh_session(old_refresh_token) do
      {:ok, %{"access_token" => new_access, "refresh_token" => new_refresh}} ->
        conn
        |> put_session(:access_token, new_access)
        |> put_session(:refresh_token, new_refresh)
        |> configure_session(renew: true)
        |> redirect(to: return_to)

      _error ->
        # Якщо рефреш не вдався (токен старий або вкрадений) — повний логаут
        conn
        |> clear_session()
        |> put_flash(:error, "Сесія закінчилася, увійдіть знову")
        |> redirect(to: "/auth")
    end
  end
end
