defmodule PeredachaWeb.Components.Shop.CategoryGrid do
  use PeredachaWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
      <%= for category <- @categories do %>
        <.link
          href={~p"/shop/category/#{category.id}"}
          class="group relative overflow-hidden rounded-xl bg-gray-200 aspect-square block"
        >
          <img
            src={category.image}
            alt={category.name}
            class="object-cover w-full h-full transition-transform duration-300 group-hover:scale-110"
          />
          <div class="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent flex flex-col justify-end p-4">
            <h3 class="text-white font-bold text-lg">{category.name}</h3>
            <p class="text-gray-200 text-sm">{category.count} items</p>
          </div>
        </.link>
      <% end %>
    </div>
    """
  end
end
