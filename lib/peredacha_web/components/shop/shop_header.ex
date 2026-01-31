defmodule PeredachaWeb.Components.ShopHeader do
  use PeredachaWeb, :html

  import PeredachaWeb.ThemeController
  import PeredachaWeb.WebUtils
  alias PeredachaWeb.Components.SocialIcons

  @spec draw(any()) :: Phoenix.LiveView.Rendered.t()
  def draw(assigns) do
    ~H"""
    <header class="fixed top-0 inset-x-0 z-50 bg-transparent backdrop-blur-sm text-white transition-colors duration-300 supports-[backdrop-filter]:bg-neutral/80 border-b border-white/5 shadow-sm">
      <div class="w-full mx-auto px-4 md:px-6 py-2">
        <div class="flex justify-between items-center gap-4">
          <% # --- LOGO --- %>
          <a href={~p"/"} class="flex items-center gap-3 group shrink-0 relative z-50">
            <div class="relative">
              <div class="absolute inset-0 bg-primary/20 blur-lg rounded-full opacity-0 group-hover:opacity-100 transition-opacity duration-500">
              </div>

              <img
                src={PeredachaWeb.Endpoint.static_path("/images/logo_5p_white.png")}
                alt="5peredacha"
                class="h-10 md:h-12 w-auto relative transition-transform duration-300 group-hover:scale-105"
              />
            </div>

            <span class="hidden xl:block text-xl font-bold tracking-wider text-white group-hover:text-primary transition-colors">
              {gettext("5 Передача")}
            </span>
          </a>
          <% # --- DESKTOP SEARCH (Hidden on Mobile) --- %>
          <div class="hidden lg:flex flex-1 max-w-xl items-center bg-white/5 border border-white/10 rounded-full px-4 py-1.5 focus-within:border-primary/50 transition-all">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-5 w-5 text-white/40"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
              />
            </svg>

            <input
              type="text"
              placeholder={gettext("Пошук запчастин за моделлю КПП...")}
              class="bg-transparent border-none focus:ring-0 text-sm w-full placeholder:text-white/30 text-white"
            />
          </div>
          <% # --- DESKTOP RIGHT MENU --- %>
          <div class="flex items-center gap-2 md:gap-4">
            <% # Navigation %>
            <nav class="hidden xxl:flex items-center gap-1 mr-2">
              <.nav_link href={~p"/"} label={gettext("На СТО")} />
              <.nav_link href={~p"/shop"} label={gettext("Каталог")} is_active />
            </nav>
            <% # Cart Icon %>
            <.link
              href="#"
              class="relative p-2 rounded-full hover:bg-white/10 transition-colors group"
            >
              <span class="absolute -top-1 -right-1 bg-primary text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full">
                0
              </span>
              <.shop_icon_small />
            </.link>
            <% # User Account %>
            <.link
              href={~p"/auth"}
              class="p-2 rounded-full hover:bg-white/10 transition-colors hidden sm:block"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6 opacity-80"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"
                />
              </svg>
            </.link>
            <% # Settings (Desktop) %>
            <div class="hidden md:flex items-center gap-2 bg-black/40 px-3 py-1.5 rounded-full border border-white/10">
              <.lang_switcher locale={@locale} />
              <div class="w-px h-4 bg-white/10"></div>
              <.theme_controller theme={@theme} />
            </div>
            <% # --- PHONE DROPDOWN (DESKTOP) --- %> <% # This is now populated with the actual contact info like the main header %>
            <div class="hidden lg:block dropdown dropdown-end dropdown-hover group/contacts">
              <div
                tabindex="0"
                role="button"
                class="btn btn-ghost btn-circle text-primary hover:bg-primary/10"
              >
                <.phone_icon_main />
              </div>

              <div tabindex="0" class="dropdown-content z-[1] pt-2 w-72 focus:outline-none">
                <div class="bg-neutral-800/95 backdrop-blur-xl border border-white/10 rounded-2xl p-5 shadow-2xl">
                  <% # Service Numbers %>
                  <div class="mb-4">
                    <h3 class="text-xs font-bold text-gray-500 uppercase tracking-widest mb-2">
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
                  <% # Shop Number %>
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
            <% # --- MOBILE HAMBURGER MENU (New Addition) --- %>
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
                  class="menu menu-lg dropdown-content bg-neutral-800/95 rounded-box w-80 border border-white/10 mt-3 z-[100] shadow-2xl"
                >
                  <% # Mobile Search %>
                  <li class="px-2 py-2">
                    <div class="flex items-center bg-white/5 border border-white/10 rounded-lg px-3 py-2">
                      <input
                        type="text"
                        placeholder={gettext("Пошук...")}
                        class="bg-transparent border-none p-0 text-sm w-full text-white placeholder:text-white/30 focus:ring-0"
                      />
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-5 w-5 text-white/40"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                        />
                      </svg>
                    </div>
                  </li>

                  <li>
                    <a href={~p"/shop"} class="text-primary font-bold">
                      <.shop_icon_small /> {gettext("Каталог Товарів")}
                    </a>
                  </li>

                  <li><a href={~p"/auth"}>{gettext("Особистий кабінет")}</a></li>

                  <li><a href={~p"/"}>{gettext("Повернутись на СТО")}</a></li>

                  <div class="divider my-2 before:bg-white/10 after:bg-white/10"></div>
                  <% # Mobile Contact Accordion %>
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
                              class="flex items-center gap-3 p-2 rounded-lg hover:bg-white/5 group"
                            >
                              <span class="text-primary"><.phone_icon_sm /></span>
                              <span class="font-medium text-gray-200">+38 (073) 916-18-42</span>
                            </a>

                            <a
                              href="tel:+380969161842"
                              class="flex items-center gap-3 p-2 rounded-lg hover:bg-white/5 group"
                            >
                              <span class="text-primary"><.phone_icon_sm /></span>
                              <span class="font-medium text-gray-200">+38 (096) 916-18-42</span>
                            </a>
                          </div>

                          <div class="divider my-1 before:bg-white/5 after:bg-white/5"></div>

                          <div>
                            <h3 class="font-bold text-white mb-1 text-base">
                              {gettext("Автомагазин")}
                            </h3>

                            <a
                              href="tel:+380674161842"
                              class="flex items-center gap-3 p-2 rounded-lg hover:bg-white/5 group"
                            >
                              <span class="text-blue-400"><.shop_icon_small /></span>
                              <span class="font-medium text-gray-200">+38 (067) 416-18-42</span>
                            </a>
                          </div>
                        </div>
                      </ul>
                    </details>
                  </li>
                  <% # Mobile Footer (Socials & Settings) %>
                  <div class="mt-2 border-t border-white/10 px-4 py-3 rounded-b-lg">
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
      </div>
    </header>
    """
  end
end
