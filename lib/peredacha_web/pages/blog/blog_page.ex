defmodule PeredachaWeb.Pages.BlogPage do
  use PeredachaWeb, :live_view

  alias Peredacha.BlogArticles
  alias PeredachaWeb.Components.PaginationComponent

  @articles_per_page 6

  def mount(_params, session, socket) do
    locale = session["locale"] || "uk"
    Gettext.put_locale(PeredachaWeb.Gettext, locale)

    all_articles = BlogArticles.get_blog_articles()
    paginated_list = Enum.chunk_every(all_articles, @articles_per_page)

    socket =
      socket
      |> assign(:page_title, gettext("Блог | 5peredacha"))
      |> assign(
        :meta_description,
        gettext("Корисні статті та поради по ремонту МКПП Renault від експертів СТО 5 Передача.")
      )
      |> assign(:current_locale, locale)
      |> assign(:all_articles, all_articles)
      |> assign(:paginated_list, paginated_list)
      |> assign(:total_pages, length(paginated_list))
      |> assign(:current_page, 1)
      |> assign(:articles, Enum.at(paginated_list, 0) || [])

    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    current_page =
      params
      |> Map.get("page", "1")
      |> String.to_integer()
      |> max(1)
      |> min(socket.assigns.total_pages)

    articles =
      socket.assigns.paginated_list
      |> Enum.at(current_page - 1, [])

    {:noreply,
     socket
     |> assign(:current_page, current_page)
     |> assign(:articles, articles)}
  end

  def render(assigns) do
    ~H"""
    <div class="relative min-h-screen flex flex-col font-sans bg-base-200/50">
      <main class="flex-1 pt-16">
        <div class="bg-base-100 py-10 border-b border-base-200">
          <div class="container mx-auto px-4">
            <div class="flex flex-col items-center text-center">
              <div class="text-xs uppercase tracking-widest text-base-content/50 mb-3">
                <a href={~p"/"} class="hover:text-primary transition-colors">{gettext("Головна")}</a>
                <span class="mx-2">/</span>
                <span class="text-base-content/80">{gettext("Блог")}</span>
              </div>

              <h1 class="text-3xl md:text-4xl font-bold mb-3 tracking-tight text-base-content">
                {gettext("Наш Блог")}
              </h1>
              <p class="text-base text-base-content/60 max-w-xl">
                {gettext("Корисні статті та поради від команди СТО 5 Передача")}
              </p>
            </div>
          </div>
        </div>

        <section class="py-12">
          <div class="container mx-auto px-4">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              <%= for article <- @articles do %>
                <div
                  class="group flex flex-col bg-base-100 border border-base-200 shadow-lg hover:shadow-2xl transition-all duration-300 rounded-2xl overflow-hidden h-full"
                  id={"article-#{article.slug}"}
                >
                  <figure class="h-56 overflow-hidden relative">
                    <img
                      src={PeredachaWeb.Endpoint.static_path("/images/blog/" <> article.image_url)}
                      alt={article.title}
                      class="w-full h-full object-cover transform group-hover:scale-105 transition-transform duration-500"
                      loading="lazy"
                    />
                  </figure>

                  <div class="p-6 flex flex-col flex-grow">
                    <div class="flex items-center gap-2 mb-3">
                      <span class="text-xs font-bold text-primary uppercase tracking-wider">
                        {article.date}
                      </span>
                    </div>

                    <h2 class="text-xl font-bold mb-3 leading-snug transition-colors line-clamp-2">
                      {article.title}
                    </h2>

                    <p class="text-sm text-base-content/70 line-clamp-3 mb-6 leading-relaxed flex-grow">
                      {article.description}
                    </p>

                    <div class="mt-auto pt-2">
                      <.link
                        navigate={~p"/blog/#{article.slug}"}
                        class="btn btn-sm rounded-full border-none w-full sm:w-auto px-6 gap-2 transition-all duration-300
                               bg-primary text-white sm:bg-primary/10 sm:text-primary
                               sm:group-hover:bg-primary sm:group-hover:text-white"
                      >
                        {gettext("Читати статтю")}
                        <svg
                          xmlns="http://www.w3.org/2000/svg"
                          fill="none"
                          viewBox="0 0 24 24"
                          stroke-width="2"
                          stroke="currentColor"
                          class="w-4 h-4 transition-transform group-hover:translate-x-1"
                        >
                          <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M13.5 4.5L21 12m0 0l-7.5 7.5M21 12H3"
                          />
                        </svg>
                      </.link>
                    </div>
                  </div>
                </div>
              <% end %>
            </div>

            <div class="mt-16 flex justify-center">
              <.live_component
                module={PaginationComponent}
                current_page={@current_page}
                total_pages={@total_pages}
                id="pagination"
              />
            </div>
          </div>
        </section>
      </main>
    </div>
    """
  end

  def handle_event("change_page", %{"page" => page}, socket) do
    page =
      page
      |> String.to_integer()
      |> max(1)
      |> min(socket.assigns.total_pages)

    {:noreply,
     socket
     |> push_patch(to: ~p"/blog?page=#{page}")
     |> push_event("scroll_top", %{})}
  end

  def handle_event("set_locale", %{"locale" => locale}, socket) do
    {:noreply, redirect(socket, to: ~p"/blog?lang=#{locale}")}
  end
end
