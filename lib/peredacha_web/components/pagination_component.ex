defmodule PeredachaWeb.Components.PaginationComponent do
  use PeredachaWeb, :live_component

  def render(assigns) do
    assigns =
      assigns
      |> assign(:pages, visible_pages(assigns.current_page, assigns.total_pages))

    ~H"""
    <div id="pagination-section" class="join shadow-sm" phx-hook="ScrollTop">
      <button
        type="button"
        phx-click="change_page"
        phx-value-page={@current_page - 1}
        class={[
          "join-item btn hover:bg-base-300",
          if(@current_page == 1, do: "btn-disabled opacity-50", else: "")
        ]}
      >
        «
      </button>

      <%= for page <- @pages do %>
        <button
          type="button"
          class={["join-item btn", if(page == @current_page, do: "btn-active btn-primary")]}
          phx-click="change_page"
          phx-value-page={page}
        >
          {page}
        </button>
      <% end %>

      <button
        type="button"
        phx-click="change_page"
        phx-value-page={@current_page + 1}
        class={[
          "join-item btn hover:bg-base-300",
          if(@current_page == @total_pages, do: "btn-disabled opacity-50", else: "")
        ]}
      >
        »
      </button>
    </div>
    """
  end

  defp visible_pages(current, total) do
    cond do
      total == 0 -> [1]
      total <= 3 -> Enum.to_list(1..total)
      current == 1 -> [1, 2, 3]
      current == total -> [total - 2, total - 1, total]
      true -> [current - 1, current, current + 1]
    end
  end
end
