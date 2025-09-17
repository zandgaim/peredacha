defmodule PeredachaWeb.Components.CarouselComponent do
  use PeredachaWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div id="main-carousel" class="relative w-full h-screen overflow-hidden">
      <!-- Slides wrapper -->
      <div
        class="flex w-full h-full transition-transform duration-700 ease-in-out"
        style={"transform: translateX(-#{@current_slide * 100}%)"}
      >
        <%= for {slide, _index} <- Enum.with_index(@slides) do %>
          <div class="relative w-full h-screen flex-shrink-0">
            <img
              src={PeredachaWeb.Endpoint.static_path(slide.image)}
              class="w-full h-full object-cover"
              alt={slide.alt || "carousel image"}
            />
            <div class="absolute inset-0 bg-black/40 flex items-center justify-center text-center px-6">
              <div class="text-white max-w-4xl">
                <h2 class="text-3xl md:text-5xl lg:text-6xl font-bold mb-4 drop-shadow-lg">
                  {slide.title}
                </h2>
                
                <p class="text-lg md:text-xl lg:text-2xl drop-shadow-lg max-w-2xl mx-auto">
                  {slide.subtitle}
                </p>
              </div>
            </div>
          </div>
        <% end %>
      </div>
      
    <!-- Scroll Down Arrow -->
      <div
        id="scroll-arrow"
        phx-hook="HideOnScroll"
        class="absolute bottom-10 left-1/2 transform -translate-x-1/2 transition-opacity duration-500"
      >
        <a
          href="#next-section"
          class="flex flex-col items-center text-yellow-500 hover:text-yellow-600 transition"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            class="w-14 h-14 animate-bounce"
          >
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
          </svg>
           <span class="mt-2 text-lg font-semibold">Далі</span>
        </a>
      </div>
    </div>
    """
  end
end
