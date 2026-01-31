defmodule PeredachaWeb.Components.Shop.FeaturedProducts do
  use PeredachaWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
      <%= for product <- @products do %>
        <div class="group bg-white border border-gray-100 rounded-2xl p-4 transition-all hover:shadow-xl">
          <div class="relative mb-4 overflow-hidden rounded-xl aspect-square bg-gray-50">
            <%= if Map.get(product, :tag) do %>
              <span class="absolute top-2 left-2 bg-red-500 text-white text-xs font-bold px-2 py-1 rounded-md z-10">
                {product.tag}
              </span>
            <% end %>
            <img
              src={product.image}
              class="object-contain w-full h-full group-hover:scale-105 transition-transform"
            />
          </div>

          <h3 class="text-gray-800 font-semibold mb-2 line-clamp-2 h-12">
            {product.name}
          </h3>

          <div class="flex items-center justify-between mt-4">
            <span class="text-xl font-bold text-blue-700">{product.price}</span>
            <button class="bg-blue-600 hover:bg-blue-700 text-white p-2 rounded-lg transition-colors">
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
                  d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"
                />
              </svg>
            </button>
          </div>
        </div>
      <% end %>
    </div>
    """
  end
end
