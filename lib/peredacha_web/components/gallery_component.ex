defmodule PeredachaWeb.Components.GalleryComponent do
  use Phoenix.LiveComponent
  alias PeredachaWeb.Pages.GallerySections

  @impl true
  def update(assigns, socket) do
    sections = assigns[:sections] || GallerySections.sections()

    socket =
      socket
      |> assign_new(:sections, fn -> sections end)
      |> assign_new(:selected_section, fn -> nil end)
      |> assign_new(:current_image_index, fn -> 0 end)

    {:ok, assign(socket, assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div
      id="gallery"
      class="scroll-mt-24 mx-auto"
      phx-window-keydown="keydown"
      phx-target={@myself}
    >
      <div class="hero bg-base rounded-none p-4 sm:p-10">
        <div class="container mx-auto">
          <div class="mx-auto mb-8 max-w-3xl text-center px-2">
            <h2 class="mb-4 text-3xl font-bold tracking-tight md:text-5xl">
              Галерея
            </h2>
            <p class="text-base text-base-content/80">
              Результати роботи СТО: професійний підхід у кожному зображенні.
            </p>
          </div>

          <!-- MOBILE + DESKTOP BENTO GRID -->
          <div class="
            grid grid-cols-2 gap-3
            auto-rows-[140px]
            sm:grid-cols-3 sm:auto-rows-[180px]
            md:grid-cols-4 md:auto-rows-[300px]
            max-w-7xl mx-auto
          ">
            <%= for {section, index} <- Enum.with_index(@sections) do %>
              <div
                phx-click="open_gallery"
                phx-target={@myself}
                phx-value-id={section.id}
                class={
                  grid_classes(index) <>
                  " group relative overflow-hidden cursor-pointer
                    rounded-xl md:rounded-3xl
                    shadow-lg hover:shadow-2xl
                    transition-all duration-500"
                }
              >
                <img
                  src={PeredachaWeb.Endpoint.static_path(section.cover)}
                  alt={section.title}
                  class="
                    w-full h-full object-cover
                    transition-transform duration-700
                    group-hover:scale-110
                  "
                />

                <div class="
                  absolute inset-0
                  bg-gradient-to-t from-black/90 via-black/30 to-transparent
                  opacity-80 md:opacity-60
                "></div>

                <div class="absolute inset-0 p-3 md:p-8 flex flex-col justify-end">
                  <h2 class="text-base md:text-3xl font-bold text-white leading-tight">
                    <%= section.title %>
                  </h2>
                </div>
              </div>
            <% end %>
          </div>

          <!-- MODAL -->
          <%= if @selected_section do %>
            <div class="fixed inset-0 z-50 bg-black/95 backdrop-blur-md flex items-center justify-center">
              <button
                phx-click="close_gallery"
                phx-target={@myself}
                class="absolute top-4 right-4 btn btn-circle btn-ghost text-white z-50"
              >
                ✕
              </button>

              <div class="w-full max-w-6xl h-full flex flex-col items-center justify-center p-4 md:p-10">
                <div class="relative w-full h-[60vh] md:h-[75vh] flex items-center justify-center overflow-hidden">
                  <% current_img = Enum.at(@selected_section.images, @current_image_index) %>

                  <img
                    key={current_img}
                    src={PeredachaWeb.Endpoint.static_path(current_img)}
                    class="max-w-full max-h-full object-contain rounded-lg shadow-2xl"
                  />

                  <!-- ALWAYS VISIBLE ARROWS -->
                  <button
                    phx-click="prev_image"
                    phx-target={@myself}
                    class="absolute left-2 top-1/2 -translate-y-1/2
                           w-11 h-11 flex items-center justify-center
                           rounded-full bg-black/50 text-white text-2xl"
                  >
                    ‹
                  </button>

                  <button
                    phx-click="next_image"
                    phx-target={@myself}
                    class="absolute right-2 top-1/2 -translate-y-1/2
                           w-11 h-11 flex items-center justify-center
                           rounded-full bg-black/50 text-white text-2xl"
                  >
                    ›
                  </button>
                </div>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    </div>
    """
  end

  # EVENTS

  @impl true
  def handle_event("open_gallery", %{"id" => id}, socket) do
    section = Enum.find(socket.assigns.sections, &(&1.id == id))
    {:noreply, assign(socket, selected_section: section, current_image_index: 0)}
  end

  def handle_event("close_gallery", _, socket) do
    {:noreply, assign(socket, selected_section: nil)}
  end

  def handle_event("next_image", _, socket) do
    %{selected_section: s, current_image_index: i} = socket.assigns
    {:noreply, assign(socket, current_image_index: rem(i + 1, length(s.images)))}
  end

  def handle_event("prev_image", _, socket) do
    %{selected_section: s, current_image_index: i} = socket.assigns
    {:noreply, assign(socket, current_image_index: if(i == 0, do: length(s.images) - 1, else: i - 1))}
  end

  def handle_event("keydown", %{"key" => key}, socket) do
    case {key, socket.assigns.selected_section} do
      {"Escape", _} -> handle_event("close_gallery", %{}, socket)
      {"ArrowRight", s} when not is_nil(s) -> handle_event("next_image", %{}, socket)
      {"ArrowLeft", s} when not is_nil(s) -> handle_event("prev_image", %{}, socket)
      _ -> {:noreply, socket}
    end
  end

  # MOBILE PATTERN:
  # 2x2, 1x2, 1x1, 1x1, 2x1
  defp grid_classes(index) do
    case rem(index, 5) do
      0 -> "col-span-2 row-span-2 md:col-span-2 md:row-span-2"
      1 -> "row-span-2 md:row-span-2"
      2 -> ""
      3 -> ""
      4 -> "col-span-2 md:col-span-2"
    end
  end
end
