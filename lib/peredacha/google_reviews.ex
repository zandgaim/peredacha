defmodule Peredacha.GoogleReviews do
  @moduledoc """
  Fetches Google Maps reviews for the 5 Передача Сервіс Renault location.
  """

  require Logger

  @endpoint "https://maps.googleapis.com/maps/api/place/details/json"
  @place_id "ChIJYWa4Ue9POkcRjKT6eMhmof8"

  def fetch_reviews do
    api_key = api_key()

    if is_nil(api_key) do
      Logger.warning("⚠️ Missing GOOGLE_PLACES_API_KEY in environment")
      []
    else
      url =
        "#{@endpoint}?place_id=#{@place_id}&fields=name,rating,reviews&language=uk&reviews_sort=newest&key=#{api_key}"

      case Req.get(url, receive_timeout: 10_000) do
        {:ok, %Req.Response{status: 200, body: body}} ->
          parse_reviews(body)

        {:ok, %Req.Response{status: status, body: body}} ->
          Logger.error("⚠️ Google API returned status #{status}: #{inspect(body)}")
          []

        {:error, reason} ->
          Logger.error("Google Places fetch failed: #{inspect(reason)}")
          []
      end
    end
  end

  defp parse_reviews(%{"result" => %{"reviews" => reviews}}) when is_list(reviews) do
    Enum.map(reviews, fn r ->
      %{
        author: r["author_name"],
        text: r["text"],
        rating: r["rating"],
        time: r["relative_time_description"],
        profile_photo: r["profile_photo_url"]
      }
    end)
  end

  defp parse_reviews(%{"error_message" => msg}) do
    Logger.error("Google API error: #{msg}")
    []
  end

  defp parse_reviews(body) when is_binary(body) do
    case Jason.decode(body) do
      {:ok, decoded} -> parse_reviews(decoded)
      {:error, _} -> []
    end
  end

  defp parse_reviews(_), do: []

  defp api_key do
    Application.get_env(:peredacha, :google_places_api_key)
  end
end
