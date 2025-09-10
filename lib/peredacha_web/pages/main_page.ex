defmodule PeredachaWeb.Pages.MainPage do
  use PeredachaWeb, :live_view

  alias PeredachaWeb.Components.Footer
  alias PeredachaWeb.Components.CarouselComponent

  def mount(_params, _session, socket) do
    page_title = "СТО ремонт КПП Renault. Ремонт МКПП Рено | 5peredacha"

    meta_description =
      "5 Передача - надійний ремонт коробок передач ➔ Ремонт МКПП Renault ⭐ СТО ремонт КПП Рено ✅ Майстри з індивідуальним підходом ✅ Вигідні ціни ☎ +38 (073) 916 1842"

    canonical_url = "https://5peredacha.com.ua/"
    og_image = "https://5peredacha.com.ua/wp-content/uploads/2023/12/renoo-788x1024.jpg"

    Process.send_after(self(), :auto_advance, 5500)

    socket =
      socket
      |> assign(:page_title, page_title)
      |> assign(:meta_description, meta_description)
      |> assign(:canonical_url, canonical_url)
      |> assign(:og_image, og_image)
      |> assign(:slides, get_slides())
      |> assign(:current_slide, 0)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="relative min-h-screen flex flex-col bg-gray-50 data-theme=dark">
      <.live_component
        module={PeredachaWeb.Components.Header}
        id="header"
        canonical_url={@canonical_url}
      />
      <main class="flex-1">
        <section class="relative w-full h-screen">
          <!-- Slides -->
          <.live_component
            module={CarouselComponent}
            id="carousel"
            slides={@slides}
            current_slide={@current_slide}
          />

          <div class="mt-8 text-center px-6">
            <button class="mt-8 bg-yellow-500 hover:bg-yellow-600 text-black font-bold py-4 px-8 rounded-lg shadow-lg transform transition-all duration-300 hover:scale-105 hover:shadow-xl">
              Записатися на ремонт
            </button>
          </div>
        </section>

        <section class="py-16 bg-white">
          <div class="container mx-auto text-center">
            <h2 class="text-3xl font-bold mb-12 text-gray-800">
              4 кроки до вирішення вашої проблеми
            </h2>

            <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
              <div class="bg-gray-50 rounded-xl shadow p-8 flex flex-col items-center">
                <div class="text-5xl text-yellow-500 font-bold mb-4">1</div>

                <h3 class="text-xl font-semibold mb-2">Дзвінок або заявка</h3>

                <p class="text-gray-600">
                  Ви телефонуєте нам або залишаєте заявку на сайті, і ми зв'язуємося з Вами.
                </p>
              </div>

              <div class="bg-gray-50 rounded-xl shadow p-8 flex flex-col items-center">
                <div class="text-5xl text-yellow-500 font-bold mb-4">2</div>

                <h3 class="text-xl font-semibold mb-2">Консультація</h3>

                <p class="text-gray-600">
                  Наш майстер уточнює деталі несправності, озвучує приблизну вартість і терміни ремонту.
                </p>
              </div>

              <div class="bg-gray-50 rounded-xl shadow p-8 flex flex-col items-center">
                <div class="text-5xl text-yellow-500 font-bold mb-4">3</div>

                <h3 class="text-xl font-semibold mb-2">Ремонт</h3>

                <p class="text-gray-600">
                  Ми знімаємо КПП, проводимо дефектування та ремонт. Надаємо фото та відеозвіт.
                </p>
              </div>

              <div class="bg-gray-50 rounded-xl shadow p-8 flex flex-col items-center">
                <div class="text-5xl text-yellow-500 font-bold mb-4">4</div>

                <h3 class="text-xl font-semibold mb-2">Готовий автомобіль</h3>

                <p class="text-gray-600">
                  Ви забираєте автомобіль з відремонтованою КПП та гарантією на виконані роботи.
                </p>
              </div>
            </div>
          </div>
        </section>

        <section class="py-16 bg-gray-100">
          <div class="container mx-auto text-center">
            <h2 class="text-3xl font-bold mb-10 text-gray-800">Моделі КПП які ми ремонтуємо</h2>

            <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4 text-lg">
              <div class="bg-white rounded shadow p-3">JH1</div>

              <div class="bg-white rounded shadow p-3">JH3</div>

              <div class="bg-white rounded shadow p-3">JR5</div>

              <div class="bg-white rounded shadow p-3">JHQ</div>

              <div class="bg-white rounded shadow p-3">JB1</div>

              <div class="bg-white rounded shadow p-3">JB3</div>

              <div class="bg-white rounded shadow p-3">JB5</div>

              <div class="bg-white rounded shadow p-3">JC5</div>

              <div class="bg-white rounded shadow p-3">JC7</div>

              <div class="bg-white rounded shadow p-3">ND0</div>

              <div class="bg-white rounded shadow p-3">ND4</div>

              <div class="bg-white rounded shadow p-3">PK4</div>

              <div class="bg-white rounded shadow p-3">PK5</div>

              <div class="bg-white rounded shadow p-3">PK6</div>

              <div class="bg-white rounded shadow p-3">PF6</div>

              <div class="bg-white rounded shadow p-3">Та інші...</div>
            </div>
          </div>
        </section>

        <section class="py-16 bg-gray-900 text-white">
          <div class="container mx-auto text-center">
            <h2 class="text-3xl font-bold mb-10">Чому обирають нас?</h2>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-12">
              <div class="bg-gray-800 rounded-xl shadow p-8">
                <h3 class="text-xl font-semibold mb-2 text-yellow-400">Досвідчені майстри</h3>

                <p>Наша команда має багаторічний досвід у ремонті коробок передач.</p>
              </div>

              <div class="bg-gray-800 rounded-xl shadow p-8">
                <h3 class="text-xl font-semibold mb-2 text-yellow-400">Гарантія якості</h3>

                <p>Надаємо гарантію на всі виконані роботи та замінені деталі.</p>
              </div>

              <div class="bg-gray-800 rounded-xl shadow p-8">
                <h3 class="text-xl font-semibold mb-2 text-yellow-400">Вигідні ціни</h3>

                <p>Пропонуємо конкурентні ціни та прозоре ціноутворення без прихованих платежів.</p>
              </div>
            </div>
          </div>
        </section>
      </main>
      <.live_component module={Footer} id="footer" />
    </div>
    """
  end

  def handle_info(:auto_advance, socket) do
    current_slide = socket.assigns.current_slide
    new_slide = if current_slide < 3, do: current_slide + 1, else: 0
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
        title: "Сучасне обладнання",
        subtitle: "Точна діагностика та якісний ремонт з використанням оригінальних запчастин",
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
        title: "Сучасне обладнання",
        subtitle: "Точна діагностика та якісний ремонт з використанням оригінальних запчастин",
        alt: "Renault Transmission Repair 2"
      }
    ]
  end
end
