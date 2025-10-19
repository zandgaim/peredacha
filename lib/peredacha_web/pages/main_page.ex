defmodule PeredachaWeb.Pages.MainPage do
  use PeredachaWeb, :live_view

  alias PeredachaWeb.Components.Footer
  alias PeredachaWeb.Components.CarouselComponent
  alias PeredachaWeb.Components.ServicesComponent
  alias PeredachaWeb.Components.DescriptionComponent
  alias PeredachaWeb.Components.Header

  def mount(_params, session, socket) do
    page_title = gettext("СТО ремонт КПП Renault. Ремонт МКПП Рено | 5peredacha")

    meta_description =
      gettext(
        "5 Передача - надійний ремонт коробок передач ➔ Ремонт МКПП Renault ⭐ СТО ремонт КПП Рено ✅ Майстри з індивідуальним підходом ✅ Вигідні ціни ☎ +38 (073) 916 1842"
      )

    canonical_url = "https://5peredacha.com.ua/"
    og_image = "https://5peredacha.com.ua/wp-content/uploads/2023/12/renoo-788x1024.jpg"
    locale = session["locale"] || "uk"
    Gettext.put_locale(PeredachaWeb.Gettext, locale)

    Process.send_after(self(), :auto_advance, 5500)

    socket =
      socket
      |> assign(:page_title, page_title)
      |> assign(:meta_description, meta_description)
      |> assign(:canonical_url, canonical_url)
      |> assign(:og_image, og_image)
      |> assign(:slides, get_slides())
      |> assign(:steps_data, get_steps_data())
      |> assign(:kpp_models, get_kpp_models())
      |> assign(:why_us_reasons, get_why_us_reasons())
      |> assign(:current_slide, 0)
      |> assign(:show_video, false)
      |> assign(:current_locale, locale)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="relative min-h-screen flex flex-col">
      <.live_component
        module={Header}
        id="header"
        canonical_url={@canonical_url}
        current_locale={@current_locale}
      />
      <main class="flex-1">
        <.live_component
          module={CarouselComponent}
          id="carousel"
          slides={@slides}
          current_slide={@current_slide}
        />

        <.live_component module={DescriptionComponent} id="description_component" steps={@steps_data} />

        <.live_component module={ServicesComponent} id="services_component" />

        <section class="py-16 bg-base-200">
          <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold mb-10 text-center">
              {gettext("Моделі КПП які ми ремонтуємо")}
            </h2>

            <%!-- Desktop: Responsive Grid (wraps automatically) --%>
            <div class="hidden md:grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-4 text-lg text-center">
              <%= for model <- @kpp_models do %>
                <div class="bg-base-100 rounded-lg shadow p-3">{model}</div>
              <% end %>
            </div>

            <%!-- Mobile: Horizontal Scroll --%>
            <div class="md:hidden">
              <div class="flex overflow-x-auto space-x-4 pb-4">
                <%= for model <- @kpp_models do %>
                  <div class="flex-shrink-0 bg-base-100 rounded-lg shadow p-3 px-6 text-lg">
                    {model}
                  </div>
                <% end %>
              </div>
            </div>
          </div>
        </section>

        <section class="py-16 bg-neutral text-neutral-content">
          <div class="container mx-auto px-4">
            <h2 class="text-3xl font-bold mb-10 text-center">{gettext("Чому обирають нас?")}</h2>

            <%!-- Desktop: 3-Column Grid --%>
            <div class="hidden md:grid grid-cols-1 md:grid-cols-3 gap-8">
              <%= for reason <- @why_us_reasons do %>
                <div class="bg-base-100/10 rounded-xl shadow p-8 text-center md:text-left">
                  <h3 class="text-xl font-semibold mb-2 text-primary">{reason.title}</h3>
                  <p>{reason.description}</p>
                </div>
              <% end %>
            </div>

            <%!-- Mobile: Horizontal Scroll with Snap --%>
            <div class="md:hidden">
              <div class="flex overflow-x-auto space-x-4 pb-4 snap-x snap-mandatory">
                <%= for reason <- @why_us_reasons do %>
                  <div class="w-4/5 flex-shrink-0 bg-base-100/10 rounded-xl shadow p-8 snap-center">
                    <h3 class="text-xl font-semibold mb-2 text-primary">{reason.title}</h3>
                    <p>{reason.description}</p>
                  </div>
                <% end %>
              </div>
            </div>
          </div>
        </section>

        <section id="contacts" class="py-16">
          <div class="container mx-auto px-4">
            <div class="text-center mb-10">
              <h2 class="text-3xl md:text-4xl font-bold mb-4">{gettext("Ми на карті")}</h2>
              <p class="text-base-content/80 text-lg">
                {gettext("Завітайте до нашого сервісу — зручно розташовані у Дрогобичі")}
              </p>
            </div>

            <div class="overflow-hidden rounded-2xl shadow-xl border border-base-content/10">
              <iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2599.785599426572!2d23.5112053!3d49.337277799999995!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x473a4fef51b86661%3A0xffa166c878faa48c!2zNSDQn9C10YDQtdC00LDRh9CwINCh0LXRgNCy0ZbRgSBSZW5hdWx0!5e0!3m2!1sru!2spl!4v1760475572653!5m2!1sru!2spl"
                width="100%"
                height="450"
                style="border:0;"
                allowfullscreen=""
                loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"
                class="w-full h-[400px] md:h-[500px]"
              >
              </iframe>
            </div>
          </div>
        </section>
      </main>
      <.live_component module={Footer} id="footer" />
    </div>
    """
  end

  def handle_event("open_video", _, socket), do: {:noreply, assign(socket, :show_video, true)}
  def handle_event("close_video", _, socket), do: {:noreply, assign(socket, :show_video, false)}

  def handle_event("set_locale", %{"locale" => locale}, socket) do
    {:noreply, push_navigate(socket, to: "/?lang=#{locale}")}
  end

  def handle_info(:auto_advance, socket) do
    current_slide = socket.assigns.current_slide
    new_slide = rem(current_slide + 1, Enum.count(socket.assigns.slides))
    socket = assign(socket, :current_slide, new_slide)
    Process.send_after(self(), :auto_advance, 5500)
    {:noreply, socket}
  end

  defp get_slides() do
    [
      %{
        image: "/images/carousel/reno3.jpg",
        title: "Сучасне обладнання",
        subtitle: "Точна діагностика та якісний ремонт з використанням оригінальних запчастин",
        alt: "Renault Transmission Repair 3"
      },
      %{
        image: "/images/carousel/reno4.jpg",
        title: "Гарантія якості",
        subtitle: "Надаємо гарантію на всі виконані роботи та замінені деталі",
        alt: "Renault Transmission Repair 4"
      },
      %{
        image: "/images/carousel/reno1.jpg",
        title: "Професійний ремонт КПП",
        subtitle: "Досвідчені майстри та гарантія якості на всі види робіт",
        alt: "Renault Transmission Repair 1"
      },
      %{
        image: "/images/carousel/reno2.jpg",
        title: "Швидке виконання",
        subtitle: "Ремонт до одного робочого дня за наявності деталей",
        alt: "Renault Transmission Repair 2"
      }
    ]
  end

  defp get_steps_data() do
    [
      %{
        title: "Дзвінок або заявка",
        description: "Ви телефонуєте нам або залишаєте заявку на сайті, і ми зв'язуємося з Вами."
      },
      %{
        title: "Перевірка та ремонт",
        description:
          "Визначаємо стан КПП, пропонуємо варіанти ремонту та якісно виконуємо роботи."
      },
      %{
        title: "Тестування та гарантія",
        description:
          "Після ремонту КПП проходить контрольну перевірку, і ви отримуєте авто у справному стані."
      }
    ]
  end

  defp get_kpp_models() do
    [
      "JH1",
      "JH3",
      "JR5",
      "JHQ",
      "JB1",
      "JB3",
      "JB5",
      "JC5",
      "JC7",
      "ND0",
      "ND4",
      "PK4",
      "PK5",
      "PK6",
      "PF6",
      gettext("Та інші...")
    ]
  end

  defp get_why_us_reasons() do
    [
      %{
        title: gettext("Досвідчені майстри"),
        description: gettext("Наша команда має багаторічний досвід у ремонті коробок передач.")
      },
      %{
        title: gettext("Гарантія якості"),
        description: gettext("Надаємо гарантію на всі виконані роботи та замінені деталі.")
      },
      %{
        title: gettext("Вигідні ціни"),
        description:
          gettext("Пропонуємо конкурентні ціни та прозоре ціноутворення без прихованих платежів.")
      }
    ]
  end
end
