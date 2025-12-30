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
    <div id="gallery" class="gallery-root" phx-window-keydown="keydown" phx-target={@myself}>
      <div class="gallery-hero">
        <div class="container mx-auto">
          <div class="gallery-header">
            <h2>Галерея</h2>

            <p>Результати роботи СТО: професійний підхід у кожному зображенні.</p>
          </div>

          <div class="gallery-grid">
            <%= for {section, index} <- Enum.with_index(@sections) do %>
              <div
                phx-click="open_gallery"
                phx-target={@myself}
                phx-value-id={section.id}
                class={"gallery-card " <> grid_classes(index)}
              >
                <img src={PeredachaWeb.Endpoint.static_path(section.cover)} alt={section.title} />
                <div class="gallery-overlay"></div>

                <div class="gallery-content">
                  <h3>{section.title}</h3>
                </div>
              </div>
            <% end %>
          </div>

          <%= if @selected_section do %>
            <div class="gallery-modal">
              <button phx-click="close_gallery" phx-target={@myself} class="gallery-close">
                ✕
              </button>

              <div class="gallery-modal-inner">
                <div class="gallery-image-wrapper">
                  <% current_img = Enum.at(@selected_section.images, @current_image_index) %>
                  <img
                    src={PeredachaWeb.Endpoint.static_path(current_img)}
                    class="gallery-modal-image"
                  />
                  <button phx-click="prev_image" phx-target={@myself} class="gallery-arrow left">
                    ‹
                  </button>

                  <button phx-click="next_image" phx-target={@myself} class="gallery-arrow right">
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

    {:noreply,
     assign(socket, current_image_index: if(i == 0, do: length(s.images) - 1, else: i - 1))}
  end

  def handle_event("keydown", %{"key" => key}, socket) do
    case {key, socket.assigns.selected_section} do
      {"Escape", _} -> handle_event("close_gallery", %{}, socket)
      {"ArrowRight", s} when not is_nil(s) -> handle_event("next_image", %{}, socket)
      {"ArrowLeft", s} when not is_nil(s) -> handle_event("prev_image", %{}, socket)
      _ -> {:noreply, socket}
    end
  end

  # MOBILE + DESKTOP POSITIONING
  defp grid_classes(index) do
    mobile =
      case rem(index, 5) do
        0 -> "mobile-2x2"
        1 -> "mobile-1x2"
        2 -> "mobile-1x1"
        3 -> "mobile-1x1"
        4 -> "mobile-2x1"
      end

    desktop =
      case rem(index, 6) do
        0 -> "desktop-2x2"
        1 -> "desktop-1x2"
        2 -> "desktop-1x2"
        3 -> "desktop-2x1"
        4 -> "desktop-2x1"
        _ -> "desktop-1x1"
      end

    mobile <> " " <> desktop
  end
end
