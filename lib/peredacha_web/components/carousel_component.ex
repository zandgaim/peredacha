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
          <!-- Single slide -->
          <div class="relative w-full h-screen flex-shrink-0">
            <img
              src={PeredachaWeb.Endpoint.static_path(slide.image)}
              class="w-full h-full object-cover"
              alt={slide.alt || "carousel image"}
            />
            <!-- Overlay with text -->
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
      <!-- Navigation dots -->
      <div class="absolute bottom-6 left-1/2 transform -translate-x-1/2 flex space-x-2 z-20">
        <%= for {_, idx} <- Enum.with_index(@slides) do %>
          <div class={[
            "w-3 h-3 rounded-full cursor-pointer transition",
            if(idx == @current_slide, do: "bg-yellow-400", else: "bg-gray-400/60")
          ]} />
        <% end %>
      </div>
    </div>
    """
  end
end
