defmodule PeredachaWeb.Components.Header do
  use PeredachaWeb, :live_component

  alias PeredachaWeb.Components.SocialIcons

  def render(assigns) do
    ~H"""
    <header class="absolute top-0 left-0 w-full z-30 bg-gray-900/40 backdrop-blur-sm text-white transition-colors duration-300">
      <div class="flex justify-between items-center py-4 px-4 md:px-6 w-full max-w-full">
        <!-- Logo -->
        <a href={@canonical_url} class="flex items-center space-x-2 group">
          <img
            src={PeredachaWeb.Endpoint.static_path("/images/logo_5p_white.png")}
            alt="5peredacha Logo"
            class="h-10 transition-transform duration-300 group-hover:scale-105"
          />
          <span class="text-xl md:text-2xl font-bold tracking-wide group-hover:text-yellow-400 transition-colors">
            5 Передача
          </span>
        </a>
        
    <!-- Desktop navigation -->
        <nav class="hidden md:flex items-center space-x-6 text-lg font-medium">
          <a href="#home" class="hover:text-yellow-400 transition-colors">Головна</a>
          <a href="#portfolio" class="hover:text-yellow-400 transition-colors">Послуги</a>
          <a href="#about" class="hover:text-yellow-400 transition-colors">Про нас</a>
          <a href="#contacts" class="hover:text-yellow-400 transition-colors">Контакти</a>
        </nav>
        
    <!-- Mobile menu -->
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
              class="menu menu-sm dropdown-content bg-gray-800/90 backdrop-blur-sm rounded-xl z-10 mt-3 w-52 p-2 shadow-lg"
            >
              <li><a href="#home">Головна</a></li>
              
              <li><a href="#portfolio">Послуги</a></li>
              
              <li><a href="#about">Про нас</a></li>
              
              <li><a href="#contacts">Контакти</a></li>
            </ul>
          </div>
        </div>
        
    <!-- Social icons -->
        <div class="hidden md:flex items-center gap-4">
          <.live_component module={SocialIcons} id="social-icons-header" />
        </div>
      </div>
    </header>
    """
  end
end
