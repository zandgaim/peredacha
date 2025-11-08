defmodule PeredachaWeb.Components.ReviewsComponent do
  use PeredachaWeb, :live_component

  def render(assigns) do
    ~H"""
    <div id="reviews" class="container scroll-mt-24 mx-auto px-4">
      <div class="relative -mx-4 md:mx-0">
        <div class="hero min-h-[50vh] bg-base-200 rounded-none md:rounded-2xl p-6 sm:p-10">
          <div class="w-full">
            <div class="mx-auto mb-12 max-w-3xl text-center px-2 md:px-0">
              <h2 class="mb-4 text-4xl font-bold tracking-tight md:text-5xl">
                Відгуки клієнтів
              </h2>
              <p class="text-lg text-base-content/80">
                Дякуємо за ваші відгуки! Ви допомагаєте нам стати кращими ❤️
              </p>
            </div>

            <%= if @reviews == [] do %>
              <p class="text-gray-500 text-center">Відгуки тимчасово недоступні.</p>
            <% else %>
              <div class="relative">
                <div
                  id="reviews-carousel"
                  class={[
                    "w-screen relative left-1/2 right-1/2 -mx-[50vw]",
                    "md:w-full md:static md:left-auto md:right-auto md:mx-0",
                    "flex items-stretch snap-x snap-mandatory gap-5 overflow-x-auto pb-6 px-5 scrollbar-none scroll-smooth"
                  ]}
                >
                  <%= for {review, index} <- Enum.with_index(@reviews) do %>
                    <div
                      id={"review-#{index}"}
                      class={[
                        "flex-shrink-0 snap-center flex basis-[85%] max-w-[85vw]",
                        "md:snap-start md:basis-1/3 md:max-w-[33.333333%]"
                      ]}
                    >
                      <.review_card review={review} class="flex-1" />
                    </div>
                  <% end %>
                </div>
              </div>
            <% end %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp review_card(assigns) do
    assigns = assign_new(assigns, :class, fn -> "" end)

    ~H"""
    <div class={[
      "flex h-full flex-col overflow-hidden rounded-2xl border border-base-content/10 bg-base-100 shadow-lg transition-all duration-300 ease-in-out",
      @class
    ]}>
      <div class="flex flex-grow flex-col p-6">
        <div>
          <div class="flex items-center justify-between mb-2">
            <span class="font-semibold text-base-content">{@review.author}</span>
            <span class="text-sm text-base-content/60">{@review.time}</span>
          </div>

          <div class="mb-2 flex items-center">
            <%= for i <- 1..5 do %>
              <%= if i <= @review.rating do %>
                <span class="text-yellow-400">★</span>
              <% else %>
                <span class="text-gray-400">★</span>
              <% end %>
            <% end %>
          </div>
        </div>

        <p class="leading-relaxed text-base-content/70 text-sm mt-2 line-clamp-6">
          {@review.text}
        </p>
      </div>
    </div>
    """
  end
end
