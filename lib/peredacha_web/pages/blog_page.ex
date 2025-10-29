defmodule PeredachaWeb.Pages.BlogPage do
  use PeredachaWeb, :live_view

  alias PeredachaWeb.Components.Footer
  alias PeredachaWeb.Components.Header

  @articles_per_page 6

  def mount(_params, session, socket) do
    page_title = gettext("Блог | 5peredacha")

    meta_description =
      gettext("Корисні статті та поради по ремонту МКПП Renault від експертів СТО 5 Передача.")

    locale = session["locale"] || "uk"
    Gettext.put_locale(PeredachaWeb.Gettext, locale)

    all_articles = get_blog_articles()
    paginated_list = Enum.chunk_every(all_articles, @articles_per_page)
    total_pages = length(paginated_list)

    socket =
      socket
      |> assign(:page_title, page_title)
      |> assign(:meta_description, meta_description)
      |> assign(:current_locale, locale)
      |> assign(:selected_article, nil)
      |> assign(:all_articles, all_articles)
      |> assign(:paginated_list, paginated_list)
      |> assign(:total_pages, total_pages)
      |> assign(:articles, Enum.at(paginated_list, 0) || [])
      |> assign(:current_page, 1)

    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    current_page =
      case String.to_integer(params["page"] || "1") do
        0 -> 1
        page -> page
      end

    paginated_list = socket.assigns.paginated_list
    current_articles = Enum.at(paginated_list, current_page - 1) || []

    socket =
      socket
      |> assign(:articles, current_articles)
      |> assign(:current_page, current_page)

    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="relative min-h-screen flex flex-col">
      <.live_component module={Header} id="header" current_locale={@current_locale} />
      <main class="flex-1">
        <section class="py-16 bg-base-200">
          <div class="container mx-auto px-4">
            <h1 class="text-4xl font-bold mb-4 text-center">
              {gettext("Наш Блог")}
            </h1>

            <p class="text-xl text-base-content/70 mb-12 text-center">
              {gettext("Корисні статті, поради та новини від нашої команди")}
            </p>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              <%= for article <- @articles do %>
                <div
                  class="card bg-base-100 shadow-xl hover:shadow-2xl transition-shadow duration-300 ease-in-out fade-in-up"
                  id={"article-#{article.slug}"}
                >
                  <figure class="aspect-h-9 aspect-w-16">
                    <img
                      src={article.image_url}
                      alt={article.title}
                      class="w-full h-full object-cover"
                      loading="lazy"
                    />
                  </figure>

                  <div class="card-body">
                    <h2 class="card-title text-xl">
                      {article.title}
                    </h2>

                    <p class="text-sm text-base-content/60 mb-2">{article.date}</p>

                    <p>{article.description}</p>

                    <div class="card-actions justify-end mt-4">
                      <button
                        class="btn btn-primary btn-sm"
                        phx-click="show_article"
                        phx-value-slug={article.slug}
                      >
                        {gettext("Читати далі")}
                        <svg
                          xmlns="http://www.w3.org/2000/svg"
                          fill="none"
                          viewBox="0 0 24 24"
                          stroke-width="1.5"
                          stroke="currentColor"
                          class="w-4 h-4"
                        >
                          <path
                            stroke-linecap="round"
                            stroke-linejoin="round"
                            d="M17.25 8.25L21 12m0 0l-3.75 3.75M21 12H3"
                          />
                        </svg>
                      </button>
                    </div>
                  </div>
                </div>
              <% end %>
            </div>

            <div classclass="mt-16 flex justify-center">
              <.pagination current_page={@current_page} total_pages={@total_pages} />
            </div>
          </div>
        </section>
      </main>
      <.live_component module={Footer} id="footer" class="fade-in-up" />
      <%= if @selected_article do %>
        <.article_modal id="article-modal" article={@selected_article} />
      <% end %>
    </div>
    """
  end

  defp pagination(assigns) do
    ~H"""
    <div id="pagination-section" class="join flex justify-center mt-12" phx-hook="ScrollTop">
      <button
        type="button"
        phx-click="change_page"
        phx-value-page={@current_page - 1}
        class={[
          "join-item btn btn-square",
          if(@current_page == 1, do: "btn-disabled opacity-50 pointer-events-none", else: "")
        ]}
        aria-label="Previous page"
      >
        «
      </button>

      <%= for page <- 1..@total_pages do %>
        <input
          type="radio"
          name="pagination"
          class="join-item btn btn-square"
          aria-label={"#{page}"}
          phx-click="change_page"
          phx-value-page={page}
          checked={page == @current_page}
        />
      <% end %>

      <button
        type="button"
        phx-click="change_page"
        phx-value-page={@current_page + 1}
        class={[
          "join-item btn btn-square",
          if(@current_page == @total_pages,
            do: "btn-disabled opacity-50 pointer-events-none",
            else: ""
          )
        ]}
        aria-label="Next page"
      >
        »
      </button>
    </div>
    """
  end

  def handle_event("change_page", %{"page" => page}, socket) do
    page = String.to_integer(page)
    page = max(1, min(page, socket.assigns.total_pages))

    {:noreply,
     socket
     |> push_patch(to: ~p"/blog?page=#{page}")
     |> push_event("scroll_top", %{})}
  end

  def handle_event("set_locale", %{"locale" => locale}, socket) do
    {:noreply, redirect(socket, to: ~p"/blog?lang=#{locale}")}
  end

  def handle_event("show_article", %{"slug" => slug}, socket) do
    article = Enum.find(socket.assigns.all_articles, &(&1.slug == slug))
    {:noreply, assign(socket, :selected_article, article)}
  end

  def handle_event("close_modal", _, socket) do
    {:noreply, assign(socket, :selected_article, nil)}
  end

  defp article_modal(assigns) do
    ~H"""
    <div
      id={@id}
      class="modal modal-open"
      phx-key={@article.slug}
      phx-click-away="close_modal"
      phx-window-keydown="close_modal"
      phx-key="Escape"
    >
      <div class="modal-box w-11/12 max-w-5xl p-0 max-h-[90vh] flex flex-col">
        <div class="absolute right-4 top-4 z-10">
          <button
            class="btn btn-sm btn-circle btn-ghost bg-base-100/50 hover:bg-base-100"
            phx-click="close_modal"
            aria-label="close modal"
          >
            ✕
          </button>
        </div>

        <figure class="w-full h-64 md:h-96 flex-shrink-0">
          <img
            src={@article.image_url}
            alt={@article.title}
            class="w-full h-full object-cover rounded-t-lg"
          />
        </figure>

        <div class="p-6 md:p-8 overflow-y-auto">
          <h3 class="font-bold text-3xl lg:text-4xl text-primary">{@article.title}</h3>

          <p class="py-2 text-sm text-base-content/60">{@article.date}</p>

          <div class="prose prose-xl max-w-none mt-4">
            {raw(@article.full_text)}
          </div>

          <div class="modal-action mt-6">
            <button class="btn" phx-click="close_modal">
              {gettext("Закрити")}
            </button>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp get_blog_articles() do
    [
      %{
        slug: "nadijni-zapchastini-dlya-korobki-peredach-reno-de-znajti",
        title: "Надійні запчастини для коробки передач Рено: де знайти?",
        date: "22.09.2024",
        description: "Дізнайтеся все про пошук хороших запчастин МКПП Рено",
        image_url: "https://placehold.co/600x400/556B8D/FFFFFF?text=Article+Image+1",
        full_text:
          "<p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          <p>'Надійні запчастини для коробки передач Рено: де знайти?'. Тут буде детальний опис, поради експертів, та інша корисна інформація.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>"
      },
      %{
        slug: "de-krasche-vikonati-diagnostiku-korobki-peredach-reno",
        title: "Де краще виконати діагностику коробки передач Рено?",
        date: "22.09.2024",
        description: "Дізнайтеся все про діагностику механічної коробки передач Renault",
        image_url: "https://placehold.co/600x400/558D6E/FFFFFF?text=Article+Image+2",
        full_text:
          "<p>'Де краще виконати діагностику коробки передач Рено?'. Розглядаємо переваги та недоліки різних СТО.</p><p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>"
      },
      %{
        slug: "koli-neobhidnij-remont-mkpp-renault",
        title: "Коли необхідний ремонт МКПП Renault?",
        date: "22.09.2024",
        description: "Дізнайтеся, в чому вразливість коробки передач Renault",
        image_url: "https://placehold.co/600x400/8D556E/FFFFFF?text=Article+Image+3",
        full_text:
          "<p>'Коли необхідний ремонт МКПП Renault?'. Головні ознаки несправності та коли не варто зволікати з візитом на сервіс.</p><p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>"
      },
      %{
        slug: "remont-korobki-renault---ekspertnist-i-turbota-pro-",
        title: "Ремонт коробки Renault – експертність і турбота про ваше авто",
        date: "22.09.2024",
        description: "Дізнайтеся, в чому особливість коробки передач Renault",
        image_url: "https://placehold.co/600x400/8D8355/FFFFFF?text=Article+Image+4",
        full_text:
          "<p>'Ремонт коробки Renault – експертність і турбота про ваше авто'.</p><p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>"
      },
      %{
        slug: "gde-luchshe-delat-remont-korobok-reno-v-ukraine",
        title: "Де краще робити ремонт коробок Рено в Україні?",
        date: "22.09.2024",
        description: "Дізнайтеся, чому автомобіліст може скаржитися на сторонні звуки з коробки",
        image_url: "https://placehold.co/600x400/556B8D/FFFFFF?text=Article+Image+5",
        full_text:
          "<p>'Де краще робити ремонт коробок Рено в Україні?'. Огляд провідних сервісних центрів.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>"
      },
      %{
        slug: "de-znajti-zapchastini-dlya-korobki-peredach-reno",
        title: "Де знайти запчастини для коробки передач Рено",
        date: "24.08.2024",
        description: "Дізнайтеся, які існують проблеми придбання запчастин для КПП Рено",
        image_url: "https://placehold.co/600x400/558D6E/FFFFFF?text=Article+Image+6",
        full_text:
          "<p>'Де знайти запчастини для коробки передач Рено'.</p><p>Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>"
      },
      %{
        slug: "profesijna-diagnostika-korobki-peredach-reno",
        title: "Професійна діагностика коробки передач Рено",
        date: "24.08.2024",
        description: "Дізнайтеся, як проводиться діагностика КПП Рено",
        image_url: "https://placehold.co/600x400/8D556E/FFFFFF?text=Article+Image+7",
        full_text:
          "<p>'Професійна діагностика коробки передач Рено'.</p><p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>"
      },
      %{
        slug: "terminovij-remont-mehanichnih-korobok-peredach-renault",
        title: "Терміновий ремонт механічних коробок передач Renault",
        date: "24.08.2024",
        description: "Дізнайтеся про переваги механічної коробки передач Рено",
        image_url: "https://placehold.co/600x400/8D8355/FFFFFF?text=Article+Image+8",
        full_text:
          "<p>'Терміновий ремонт механічних коробок передач Renault'.</p><p>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>"
      },
      %{
        slug: "osoblivosti-remontu-robotizovanih-kpp-reno",
        title: "Особливості ремонту роботизованих КПП Рено",
        date: "24.08.2024",
        description: "Дізнайтеся усе про роботизовану коробку передач Рено",
        image_url: "https://placehold.co/600x400/556B8D/FFFFFF?text=Article+Image+9",
        full_text:
          "<p>'Особливості ремонту роботизованих КПП Рено'.</p><p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>"
      },
      %{
        slug: "profesijna-diagnostika-ta-remont-korobok-reno",
        title: "Професійна діагностика та ремонт коробок Рено",
        date: "24.08.2024",
        description: "Дізнайтеся, коли виникають проблеми із трансмісією у Рено",
        image_url: "https://placehold.co/600x400/558D6E/FFFFFF?text=Article+Image+10",
        full_text:
          "<p>'Професійна діагностика та ремонт коробок Рено'.</p><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>"
      },
      %{
        slug: "chomu-dovoditsya-provoditi-remont-kpp-reno",
        title: "Чому доводиться проводити ремонт КПП Рено",
        date: "27.07.2024",
        description: "Дізнайтеся, коли знадобиться ремонт КПП Renault",
        image_url: "https://placehold.co/600x400/8D556E/FFFFFF?text=Article+Image+11",
        full_text:
          "<p>'Чому доводиться проводити ремонт КПП Рено'.</p><p>Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>"
      },
      %{
        slug: "yak-viznachiti-neobhidnist-remontu-kpp-renault",
        title: "Як визначити необхідність ремонту КПП Renault",
        date: "27.07.2024",
        description: "Дізнайтеся більше про ремонт КПП Renault",
        image_url: "https://placehold.co/600x400/8D8355/FFFFFF?text=Article+Image+12",
        full_text:
          "<p>'Як визначити необхідність ремонту КПП Renault'.</p><p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>"
      }
    ]
  end
end
