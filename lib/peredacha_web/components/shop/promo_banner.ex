defmodule PeredachaWeb.Components.Shop.PromoBanner do
  use PeredachaWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="bg-indigo-900 rounded-2xl overflow-hidden my-12">
      <div class="flex flex-col md:flex-row items-center">
        <div class="p-8 md:p-12 md:w-1/2">
          <span class="text-indigo-300 font-bold tracking-widest uppercase text-sm">
            Special Offer
          </span>
          <h2 class="text-3xl md:text-4xl font-extrabold text-white mt-4 mb-6">
            Everything you need for Renault Transmissions in one place.
          </h2>
          <button class="bg-white text-indigo-900 px-8 py-3 rounded-full font-bold hover:bg-gray-100 transition-colors">
            Claim 10% Discount
          </button>
        </div>
        <div class="md:w-1/2 h-64 md:h-auto overflow-hidden">
          <img src="/images/promo-gears.jpg" class="object-cover w-full h-full opacity-80" />
        </div>
      </div>
    </div>
    """
  end
end
