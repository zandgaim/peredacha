defmodule PeredachaWeb.Components.Header do
  use PeredachaWeb, :live_component

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
        <%!-- <.theme_toggle /> --%>
        <div class="flex items-center gap-8">
          <div class="text-right">
            <a href="tel:+380739161842" class="block hover:text-yellow-400 transition">
              +38 (073) 916 18 42
            </a>
            <a href="tel:+380969161842" class="block hover:text-yellow-400 transition">
              +38 (096) 916 18 42
            </a>
          </div>
          <button class="bg-yellow-500 text-black font-semibold py-2 px-5 rounded-lg shadow hover:bg-yellow-600 transition">
            Замовити дзвінок
          </button>
        </div>
      </div>
    </header>
    """
  end
end
