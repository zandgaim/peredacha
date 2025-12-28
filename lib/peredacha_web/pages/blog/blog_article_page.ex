defmodule PeredachaWeb.Pages.BlogArticlePage do
  use PeredachaWeb, :live_view

  alias Peredacha.BlogArticles

  @impl true
  def mount(%{"slug" => slug}, session, socket) do
    locale = session["locale"] || "uk"
    Gettext.put_locale(PeredachaWeb.Gettext, locale)

    case find_article(slug) do
      nil ->
        raise Phoenix.Router.NoRouteError, message: "Article not found"

      article ->
        {:ok,
         socket
         |> assign(:article, article)
         |> assign(:page_title, "#{article.title} | 5peredacha")
         |> assign(:meta_description, article.description)
         |> assign(:current_locale, locale)}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-base-200 min-h-screen py-10">
      <div class="container mx-auto px-4 max-w-4xl">
        <div class="text-sm breadcrumbs mb-6 text-base-content/70">
          <ul>
            <li><.link navigate={~p"/"}>{gettext("Головна")}</.link></li>
            <li><.link navigate={~p"/blog"}>{gettext("Блог")}</.link></li>
            <li><span class="font-medium text-base-content">{@article.title}</span></li>
          </ul>
        </div>

        <article class="card bg-base-100 shadow-xl overflow-hidden">
          <figure class="w-full h-64 md:h-96 relative">
            <img
              src={PeredachaWeb.Endpoint.static_path("/images/blog/" <> @article.image_url)}
              alt={@article.title}
              class="w-full h-full object-cover"
            />
            <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>

            <div class="absolute bottom-0 left-0 p-6 md:p-10 text-white">
              <h1 class="text-3xl md:text-5xl font-bold leading-tight mb-2">
                {@article.title}
              </h1>

              <div class="flex items-center gap-2 text-sm md:text-base opacity-90">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  class="w-5 h-5"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 012.25-2.25h13.5A2.25 2.25 0 0121 7.5v11.25m-18 0h18"
                  />
                </svg>
                <time>{@article.date}</time>
              </div>
            </div>
          </figure>

          <div class="card-body p-6 md:p-12">
            <div class="prose prose-lg max-w-none
            prose-headings:font-bold
            prose-a:text-primary
            prose-a:underline
            prose-a:underline-offset-4">
              {raw(render_markdown(@article.full_text))}
            </div>

            <div class="divider my-10"></div>

            <div class="flex justify-between items-center">
              <.link navigate={~p"/blog"} class="btn btn-outline gap-2 group">
                <span class="group-hover:-translate-x-1 transition-transform">←</span>
                {gettext("До списку статей")}
              </.link>
            </div>
          </div>
        </article>
      </div>
    </div>
    """
  end

  defp render_markdown(markdown) when is_binary(markdown) do
    Earmark.as_html!(markdown)
  end

  defp find_article(slug) do
    Peredacha.BlogArticles.get_blog_articles()
    |> Enum.find(&(&1.slug == slug))
  end
end
