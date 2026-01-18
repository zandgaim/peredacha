defmodule PeredachaWeb.Components.Header do
  use PeredachaWeb, :html
  import PeredachaWeb.ThemeController

  alias PeredachaWeb.Components.SocialIcons

  def draw(assigns) do
    ~H"""
    <header class="fixed top-0 inset-x-0 z-50 bg-transparent backdrop-blur-sm text-white transition-colors duration-300 supports-[backdrop-filter]:bg-neutral/80 border-b border-white/5 shadow-sm">
      <div class="w-full  mx-auto px-4 md:px-6 py-2">
        <div class="flex justify-between items-center">
          <a href={~p"/"} class="flex items-center gap-3 group relative z-50">
            <div class="relative">
              <div class="absolute inset-0 bg-primary/20 blur-lg rounded-full opacity-0 group-hover:opacity-100 transition-opacity duration-500">
              </div>

              <img
                src={PeredachaWeb.Endpoint.static_path("/images/logo_5p_white.png")}
                alt="5peredacha"
                class="h-10 md:h-12 w-auto relative transition-transform duration-300 group-hover:scale-105"
              />
            </div>

            <span class="hidden sm:block text-xl md:text-2xl font-bold tracking-wider text-white group-hover:text-primary transition-colors">
              {gettext("5 Передача")}
            </span>
          </a>

          <div class="hidden lg:flex absolute left-1/2 -translate-x-1/2 items-center gap-1 bg-neutral-900/40 p-1 rounded-full border border-white/5 backdrop-blur-sm">
            <a
              href={~p"/#home"}
              class="px-5 py-2 rounded-full hover:bg-white/10 text-white transition-all font-medium"
            >
              {gettext("Головна")}
            </a>

            <a
              href={~p"/#services"}
              class="px-5 py-2 rounded-full hover:bg-white/10 text-white transition-all font-medium"
            >
              {gettext("Послуги")}
            </a>

            <a
              href={~p"/shop"}
              class="px-5 py-2 rounded-full bg-primary/10 hover:bg-primary/20 text-primary hover:text-primary-focus transition-all font-semibold flex items-center gap-2"
            >
              <.shop_icon_small /> {gettext("Магазин")}
            </a>

            <div class="dropdown dropdown-hover group/menu">
              <div
                tabindex="0"
                role="button"
                class="px-5 py-2 rounded-full hover:bg-white/10 text-white transition-all font-medium flex items-center gap-1 cursor-default"
              >
                {gettext("Інфо")}
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-4 w-4 opacity-70 group-hover/menu:rotate-180 transition-transform duration-300"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                >
                  <path
                    fill-rule="evenodd"
                    d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z"
                    clip-rule="evenodd"
                  />
                </svg>
              </div>

              <ul tabindex="0" class="dropdown-content z-[1] pt-4 w-52 focus:outline-none">
                <div class="bg-neutral-800/95 backdrop-blur-xl border border-white/10 rounded-2xl p-2 shadow-2xl">
                  <li>
                    <a
                      href={~p"/#about"}
                      class="block px-4 py-2 rounded-xl hover:bg-white/10 hover:text-primary transition-colors"
                    >
                      {gettext("Про нас")}
                    </a>
                  </li>

                  <li>
                    <a
                      href={~p"/#gallery"}
                      class="block px-4 py-2 rounded-xl hover:bg-white/10 hover:text-primary transition-colors"
                    >
                      {gettext("Галерея")}
                    </a>
                  </li>

                  <li>
                    <a
                      href={~p"/blog"}
                      class="block px-4 py-2 rounded-xl hover:bg-white/10 hover:text-primary transition-colors"
                    >
                      {gettext("Блог")}
                    </a>
                  </li>
                </div>
              </ul>
            </div>
          </div>

          <div class="hidden lg:flex items-center gap-3">
            <div class="flex items-center gap-2 bg-black/20 px-3 py-1.5 rounded-full border border-white/5">
              <.lang_switcher locale={@locale} />
              <div class="w-px h-4 bg-white/10"></div>
              <.theme_controller theme={@theme} />
            </div>

            <div class="dropdown dropdown-end dropdown-hover group/contacts">
              <div
                tabindex="0"
                role="button"
                class="btn btn-ghost btn-circle text-primary hover:bg-primary/10"
              >
                <.phone_icon_main />
              </div>

              <div tabindex="0" class="dropdown-content z-[1] pt-2 w-72 focus:outline-none">
                <div class="bg-neutral-800/95 backdrop-blur-xl border border-white/10 rounded-2xl p-5 shadow-2xl">
                  <div class="mb-4">
                    <h3 class="text-white font-bold text-gray-500 uppercase tracking-widest mb-2">
                      {gettext("СТО Сервіс")}
                    </h3>

                    <div class="space-y-2">
                      <a
                        href="tel:+380739161842"
                        class="flex items-center gap-3 p-2 rounded-lg hover:bg-white/5 group transition-colors"
                      >
                        <span class="p-2 rounded-full bg-primary/10 text-white group-hover:bg-primary group-hover:text-white transition-colors">
                          <.phone_icon_sm />
                        </span>
                        <span class="font-medium text-gray-200">+38 (073) 916-18-42</span>
                      </a>

                      <a
                        href="tel:+380969161842"
                        class="flex items-center gap-3 p-2 rounded-lg hover:bg-white/5 group transition-colors"
                      >
                        <span class="p-2 rounded-full bg-primary/10 text-white group-hover:bg-primary group-hover:text-white transition-colors">
                          <.phone_icon_sm />
                        </span>
                        <span class="font-medium text-gray-200">+38 (096) 916-18-42</span>
                      </a>
                    </div>
                  </div>

                  <div class="pt-4 border-t border-white/10">
                    <h3 class="text-xs font-bold text-gray-500 uppercase tracking-widest mb-2">
                      {gettext("Автомагазин")}
                    </h3>

                    <a
                      href="tel:+380674161842"
                      class="flex items-center gap-3 p-2 rounded-lg hover:bg-white/5 group transition-colors"
                    >
                      <span class="p-2 rounded-full bg-blue-500/10 text-blue-400 group-hover:bg-blue-500 group-hover:text-white transition-colors">
                        <.shop_icon_small />
                      </span>
                      <span class="font-medium text-gray-200">+38 (067) 416-18-42</span>
                    </a>
                  </div>
                </div>
              </div>
            </div>

            <div class="ml-2">
              <SocialIcons.draw id="social-header" />
            </div>
          </div>

          <div class="lg:hidden">
            <div class="dropdown dropdown-end">
              <div tabindex="0" role="button" class="btn btn-ghost btn-circle text-white">
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
                class="menu menu-lg dropdown-content  bg-neutral-800/95 rounded-box w-80 border border-white/10"
              >
                <li><a href={~p"/#home"}>{gettext("Головна")}</a></li>

                <li><a href={~p"/#services"}>{gettext("Послуги")}</a></li>

                <li>
                  <a href={~p"/shop"} class="text-primary font-bold">
                    <.shop_icon_small /> {gettext("Автомагазин")}
                  </a>
                </li>

                <%!-- <div class="divider цр my-1"></div> --%>
                <div class="divider my-2 before:bg-white/10 after:bg-white/10"></div>

                <li>
                  <details>
                    <summary>{gettext("Інформація")}</summary>

                    <ul>
                      <li><a href={~p"/#about"}>{gettext("Про нас")}</a></li>

                      <li><a href={~p"/#gallery"}>{gettext("Галерея")}</a></li>

                      <li><a href={~p"/blog"}>{gettext("Блог")}</a></li>
                    </ul>
                  </details>
                </li>

                <li tabindex="0">
                  <details>
                    <summary class="cursor-pointer transition-colors text-lg">
                      {gettext("Контакти")}
                    </summary>

                    <ul>
                      <div class="mt-2 ml-2 space-y-2">
                        <div>
                          <h3 class="font-bold text-white mb-1 text-base">{gettext("СТО")}</h3>

                          <a
                            href="tel:+380739161842"
                            class="flex items-center gap-3 p-2 rounded-lg hover:bg-white/5 group transition-colors"
                          >
                            <span class="p-2 rounded-full bg-primary/10 text-white group-hover:bg-primary group-hover:text-white transition-colors">
                              <.phone_icon_sm />
                            </span>
                            <span class="font-medium text-gray-200">+38 (073) 916-18-42</span>
                          </a>

                          <a
                            href="tel:+380969161842"
                            class="flex items-center gap-3 p-2 rounded-lg hover:bg-white/5 group transition-colors"
                          >
                            <span class="p-2 rounded-full bg-primary/10 text-white group-hover:bg-primary group-hover:text-white transition-colors">
                              <.phone_icon_sm />
                            </span>
                            <span class="font-medium text-gray-200">+38 (096) 916-18-42</span>
                          </a>
                        </div>

                        <div class="divider my-2 before:bg-white/10 after:bg-white/10"></div>

                        <div>
                          <h3 class="font-bold text-white mb-1 text-base">
                            {gettext("Автомагазин")}
                          </h3>

                          <a
                            href="tel:+380674161842"
                            class="flex items-center gap-3 p-2 rounded-lg hover:bg-white/5 group transition-colors"
                          >
                            <span class="p-2 rounded-full bg-blue-500/10 text-blue-400 group-hover:bg-blue-500 group-hover:text-white transition-colors">
                              <.shop_icon_small />
                            </span>
                            <span class="font-medium text-gray-200">+38 (067) 416-18-42</span>
                          </a>
                        </div>
                      </div>
                    </ul>
                  </details>
                </li>

                <div class="mt-2 border-t border-white/10  px-4 py-3 rounded-b-lg">
                  <div class="flex flex-col items-center justify-center mb-3">
                    <span class="text-[10px] uppercase tracking-widest text-white/40 font-semibold mb-2">
                      {gettext("Ми в соцмережах")}
                    </span>
                    <div class="flex gap-3 opacity-80 hover:opacity-100 transition-opacity">
                      <SocialIcons.draw />
                    </div>
                  </div>

                  <div class="flex items-center justify-between bg-black/20 rounded-md p-1.5">
                    <div class="flex-1 flex justify-center border-r border-white/5 pr-2">
                      <.theme_controller theme={@theme} />
                    </div>
                    <div class="flex-1 flex justify-center pl-2">
                      <.lang_switcher locale={@locale} />
                    </div>
                  </div>
                </div>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </header>
    """
  end

  # --- ICONS & HELPERS ---

  defp lang_switcher(assigns) do
    ~H"""
    <div class="flex items-center space-x-1">
      <button
        phx-click="set_locale"
        phx-value-locale="uk"
        class={"px-3 py-1 rounded-full transition-all duration-300 " <>
               if @locale == "uk",
                 do: "bg-primary text-white font-semibold shadow-md",
                 else: "hover:bg-white/10"}
        aria-label="Switch to Ukrainian"
        disabled={@locale == "uk"}
      >
        UA
      </button>

      <button
        phx-click="set_locale"
        phx-value-locale="en"
        class={"px-3 py-1 rounded-full transition-all duration-300 " <>
               if @locale == "en",
                 do: "bg-primary text-white font-semibold shadow-md",
                 else: "hover:bg-white/10"}
        aria-label="Switch to English"
        disabled={@locale == "en"}
      >
        EN
      </button>
    </div>
    """
  end

  defp shop_icon_small(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      class="h-5 w-5"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"
      />
    </svg>
    """
  end

  defp phone_icon_main(assigns) do
    ~H"""
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
        d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"
      />
    </svg>
    """
  end

  defp phone_icon_sm(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      class="h-4 w-4"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"
      />
    </svg>
    """
  end
end
