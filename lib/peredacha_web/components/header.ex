defmodule PeredachaWeb.Components.Header do
  use PeredachaWeb, :live_component
  import PeredachaWeb.ThemeController

  alias PeredachaWeb.Components.SocialIcons
  alias PeredachaWeb.Gettext

  @impl true
  def update(assigns, socket) do
    locale = assigns[:current_locale] || Gettext.get_locale() || "uk"

    socket =
      socket
      |> assign(assigns)
      |> assign(:locale, locale)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <header class="fixed top-0 inset-x-0 z-50 bg-transparent backdrop-blur-sm text-white transition-colors duration-300 supports-[backdrop-filter]:bg-neutral/60">
      <div class="flex justify-between items-center py-4 px-4 md:px-6 w-full max-w-full">
        <a href={@canonical_url} class="flex items-center space-x-2 group">
          <img
            src={PeredachaWeb.Endpoint.static_path("/images/logo_5p_white.png")}
            alt="5peredacha Logo"
            class="h-10 transition-transform duration-300 group-hover:scale-105"
          />
          <span class="text-xl md:text-2xl font-bold tracking-wide group-hover:text-primary transition-colors">
            {gettext("5 Передача")}
          </span>
        </a>

        <div class="hidden md:flex items-center gap-5">
          <nav class="flex items-center space-x-6 text-lg font-medium">
            <a href="#home" class="hover:text-primary transition-colors">{gettext("Головна")}</a>
            <a href="#about" class="hover:text-primary transition-colors">{gettext("Про нас")}</a>
            <a href="#services" class="hover:text-primary transition-colors">{gettext("Послуги")}</a>
            <div class="dropdown">
              <div tabindex="0" role="button" class="hover:text-primary cursor-pointer">
                {gettext("Контакти")}
              </div>
              <div
                tabindex="0"
                class="dropdown-content bg-gray-800/90 backdrop-blur-sm rounded-xl shadow-lg w-64 mt-4 p-4 z-[1] text-gray-200"
              >
                <div>
                  <h3 class="font-bold text-white mb-2 text-base">{gettext("СТО")}</h3>
                  <a href="tel:+380739161842" class="flex items-center space-x-2 hover:text-primary">
                    <.phone_icon /> <span>+38 (073) 916-18-42</span>
                  </a>
                  <a href="tel:+380969161842" class="flex items-center space-x-2 hover:text-primary">
                    <.phone_icon /> <span>+38 (096) 916-18-42</span>
                  </a>
                </div>
                <div class="border-t border-gray-600 my-2"></div>
                <div class="mb-3">
                  <h3 class="font-bold text-white mb-2 text-base">{gettext("Автомагазин")}</h3>
                  <a href="tel:+380674161842" class="flex items-center space-x-2 hover:text-primary">
                    <.phone_icon /> <span>+38 (067) 416-18-42</span>
                  </a>
                </div>
              </div>
            </div>
          </nav>

          <div class="w-px h-6 bg-white/20"></div>

          <div class="flex items-center gap-4">
            <.theme_controller />

            <.lang_switcher locale={@locale} />

            <div class="w-px h-6 bg-white/20"></div>
            <.live_component module={SocialIcons} id="social-icons-header" />
          </div>
        </div>

        <div class="md:hidden">
          <div class="dropdown dropdown-end">
            <div tabindex="0" role="button" class="btn btn-ghost btn-circle">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M4 6h16M4 12h16M4 18h7"
                />
              </svg>
            </div>
            <ul
              tabindex="0"
              class="menu menu-sm dropdown-content bg-gray-800/90 backdrop-blur-sm rounded-xl z-10 mt-3 w-60 p-3 shadow-lg text-gray-200 text-lg"
            >
              <li class="flex flex-col items-center py-1">
                <span class="text-xs uppercase tracking-wider text-gray-400 mb-0.5">
                  {gettext("Ми в соцмережах")}
                </span>
                <div class="flex gap-2">
                  <.live_component module={SocialIcons} id="social-icons-mobile" />
                </div>
              </li>

              <li class="border-t border-gray-600 my-1"></li>

              <li><a class="text-lg" href="#home">{gettext("Головна")}</a></li>
              <li><a class="text-lg" href="#about">{gettext("Про нас")}</a></li>
              <li><a class="text-lg" href="#services">{gettext("Послуги")}</a></li>

              <li tabindex="0">
                <details>
                  <summary class="cursor-pointerz transition-colors text-lg">
                    {gettext("Контакти")}
                  </summary>

                  <div class="mt-2 ml-2">
                    <h3 class="font-bold text-white mb-1 text-base">{gettext("СТО")}</h3>

                    <a
                      href="tel:+380739161842"
                      class="flex items-center space-x-2 hover:text-primary transition-colors group mb-1 text-lg"
                    >
                      <.phone_icon /> <span>+38 (073) 916-18-42</span>
                    </a>
                    <a
                      href="tel:+380969161842"
                      class="flex items-center space-x-2 hover:text-primary transition-colors group mb-2 text-lg"
                    >
                      <.phone_icon /> <span>+38 (096) 916-18-42</span>
                    </a>
                    <div class="border-t border-gray-600 my-2"></div>
                    <h3 class="font-bold text-white mb-1 text-base">{gettext("Автомагазин")}</h3>
                    <a
                      href="tel:+380674161842"
                      class="flex items-center space-x-2 hover:text-primary transition-colors group text-lg"
                    >
                      <.phone_icon /> <span>+38 (067) 416-18-42</span>
                    </a>
                  </div>
                </details>
              </li>

              <li class="border-t border-gray-600 my-1"></li>

              <li class="flex flex-row justify-center items-center gap-2 py-2">
                <.lang_switcher locale={@locale} />
              </li>
            </ul>
          </div>
        </div>
      </div>
    </header>
    """
  end

  # NEW: Language Switcher function component
  defp lang_switcher(assigns) do
    ~H"""
    <div class="flex items-center gap-2 font-medium text-sm">
      <a href="/?lang=uk"
         class={["hover:text-primary transition-colors", @locale == "uk" && "text-primary font-bold", @locale != "uk" && "opacity-70"]}
      >
        UA
      </a>
      <span class="text-white/30">|</span>
      <a href="/?lang=en"
         class={["hover:text-primary transition-colors", @locale == "en" && "text-primary font-bold", @locale != "en" && "opacity-70"]}
      >
        EN
      </a>
    </div>
    """
  end

  defp phone_icon(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      class="h-5 w-5 text-gray-400 group-hover:text-primary transition-colors"
      viewBox="0 0 20 20"
      fill="currentColor"
    >
      <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z" />
    </svg>
    """
  end
end
