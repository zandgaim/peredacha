defmodule PeredachaWeb.Components.Header do
  use PeredachaWeb, :live_component

  alias PeredachaWeb.Components.SocialIcons

  def render(assigns) do
    ~H"""
    <header class="bg-gray-900 text-white shadow-lg">
      <div class="container mx-auto flex justify-between items-center py-4 px-2">
        <a href={@canonical_url} class="flex items-center space-x-2">
          <img
            src={PeredachaWeb.Endpoint.static_path("/images/logo_5p_white.png")}
            alt="5peredacha Logo"
            class="h-10"
          />
          <span class="text-xl font-bold tracking-wide">5 Передача</span>
        </a>
        <div class="flex items-center gap-8">
          <.live_component module={SocialIcons} id="social-icons-header" />
        </div>
      </div>
    </header>
    """
  end
end
