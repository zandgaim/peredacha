defmodule Peredacha.CoreApiClient do
  require Logger

  @login_query """
    mutation Login($email: String!, $password: String!, $store_slug: String!) {
      login(email: $email, password: $password, store_slug: $store_slug) {
        access_token
        refresh_token
        user { email }
      }
    }
  """

  @logout_query """
    mutation Logout($refresh_token: String!) {
      logout(refresh_token: $refresh_token)
    }
  """

  @register_query """
    mutation Register($email: String!, $password: String!, $store_slug: String!) {
      register(email: $email, password: $password, store_slug: $store_slug) {
        access_token
        refresh_token
        user { email }
      }
    }
  """

  @refresh_session_query """
    mutation Refresh($token: String!) {
      refresh_session(refresh_token: $token) {
        access_token
        refresh_token
      }
    }
  """

  @get_user_by_token_query """
    query {
      get_user_by_token {
        id
        email
      }
    }
  """

  # --- Public API ---
  def login(email, password) do
    Logger.info("api_called: login #{email}")
    store_slug = get_store_slug()
    variables = %{email: email, password: password, store_slug: store_slug}

    @login_query
    |> post_graphql(variables)
    |> handle_response("login")
  end

  def logout(access_token, refresh_token) do
    Logger.info("api_called: logout")
    variables = %{refresh_token: refresh_token}

    @logout_query
    |> post_graphql(variables, access_token)
    |> handle_response("logout")
  end

  def register(email, password) do
    Logger.info("api_called: register #{email}")
    store_slug = get_store_slug()
    variables = %{email: email, password: password, store_slug: store_slug}

    @register_query
    |> post_graphql(variables)
    |> handle_response("register")
  end

  def refresh_session(refresh_token) do
    Logger.info("api_called: refresh_session")
    variables = %{token: refresh_token}

    @refresh_session_query
    |> post_graphql(variables)
    |> handle_response("refresh_session")
  end

  def get_user_by_token(token) do
    Logger.info("api_called: get_user_by_token")
    variables = %{}

    @get_user_by_token_query
    |> post_graphql(variables, token)
    |> handle_response("get_user_by_token")
  end

  # --- Private Helpers ---
  defp post_graphql(query, variables, token \\ nil) do
    store_headers = [
      {"x-store-slug", get_store_slug()},
      {"x-store-secret", get_store_secret()}
    ]

    user_headers =
      if token do
        [{"authorization", "Bearer #{token}"}]
      else
        []
      end

    # 3. Об'єднуємо всі заголовки
    all_headers = store_headers ++ user_headers

    api_url = get_api_url()

    # Req автоматично додає content-type: application/json, якщо передано option json: ...
    Req.post(api_url,
      json: %{query: query, variables: variables},
      headers: all_headers
    )
  end

  defp handle_response({:ok, %{status: 200, body: body}}, operation_name) do
    cond do
      Map.has_key?(body, "errors") ->
        error_msg = parse_errors(body["errors"])
        Logger.error("GraphQL Error [#{operation_name}]: #{error_msg}")
        {:error, error_msg}

      get_in(body, ["data", operation_name]) ->
        session = get_in(body, ["data", operation_name])
        {:ok, session}

      true ->
        Logger.error("Unexpected response for [#{operation_name}]: #{inspect(body)}")
        {:error, "Невідома помилка API (Invalid Response Structure)"}
    end
  end

  defp handle_response({:ok, %{status: 403, body: body}}, _op) do
     Logger.error("store Auth Failed: #{inspect(body)}")
     {:error, "Помилка конфігурації магазину (Unauthorized store)"}
  end

  defp handle_response({:ok, %{status: status, body: body}}, _op) do
    Logger.error("HTTP Error #{status}: #{inspect(body)}")
    {:error, "Сервер повернув помилку #{status}"}
  end

  defp handle_response({:error, reason}, _op) do
    Logger.error("Connection Error: #{inspect(reason)}")
    {:error, "Не вдалося з'єднатися з CoreService"}
  end

  defp parse_errors(errors) when is_list(errors) do
    errors
    |> List.first()
    |> Map.get("message", "Невідома помилка валідації")
  end

  defp parse_errors(_), do: "Невідома помилка"

  defp get_store_slug(), do: config()[:store_slug]
  defp get_api_url(), do: config()[:api_url] || "http://localhost:4000/api/graphql"
  defp get_store_secret(), do: config()[:store_secret] || raise "store Secret not configured!"

  defp config(), do: Application.get_env(:peredacha, __MODULE__)
end
