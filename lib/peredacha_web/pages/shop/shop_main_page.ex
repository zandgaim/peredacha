defmodule PeredachaWeb.Pages.ShopMainPage do
  use PeredachaWeb, :live_view

  alias PeredachaWeb.Components.Shop.{FeaturedProducts, VehicleSelector}

  def mount(_params, _session, socket) do
    # 1. Макро-категорії (Top Level Hierarchy)
    # Ми ділимо асортимент на логічні блоки, щоб не змішувати "мух з котлетами"
    categories_tree = [
      %{
        title: "Агрегати та Вузли",
        description: "Готові до встановлення коробки передач та двигуни",
        slug: "assemblies",
        items: [
          %{
            id: 1,
            name: "КПП в зборі (Gearboxes)",
            image: "/images/cat/gearbox_full.jpg",
            url: "/shop/cat/gearboxes"
          },
          %{
            id: 2,
            name: "Двигуни (Engines)",
            image: "/images/cat/engine_full.jpg",
            url: "/shop/cat/engines"
          }
        ]
      },
      %{
        title: "Запчастини Трансмісії",
        description: "Компоненти для ремонту КПП",
        slug: "transmission-parts",
        items: [
          %{
            id: 3,
            name: "Підшипники (Bearings)",
            image: "/images/cat/bearings.jpg",
            url: "/shop/cat/bearings"
          },
          %{
            id: 4,
            name: "Шестерні та Вали",
            image: "/images/cat/gears.jpg",
            url: "/shop/cat/gears"
          },
          %{id: 5, name: "Диференціали", image: "/images/cat/diff.jpg", url: "/shop/cat/diff"},
          %{
            id: 6,
            name: "Сальники та прокладки",
            image: "/images/cat/seals.jpg",
            url: "/shop/cat/seals"
          }
        ]
      },
      %{
        title: "Зчеплення та Маховики",
        slug: "clutch-systems",
        description: "",
        items: [
          %{
            id: 7,
            name: "Комплекти зчеплення",
            image: "/images/cat/clutch_kit.jpg",
            url: "/shop/cat/clutch"
          },
          %{
            id: 8,
            name: "Гідравліка (Циліндри)",
            image: "/images/cat/hydraulics.jpg",
            url: "/shop/cat/hydraulics"
          }
        ]
      },
      %{
        title: "Мастила та Сервіс",
        slug: "oils-fluids",
        description: "",
        items: [
          %{
            id: 9,
            name: "Трансмісійні олії",
            image: "/images/cat/oil.jpg",
            url: "/shop/cat/oils"
          },
          %{
            id: 10,
            name: "Герметики та хімія",
            image: "/images/cat/chemicals.jpg",
            url: "/shop/cat/chemicals"
          }
        ]
      }
    ]

    # 2. Featured Products - Розширені для різних сегментів
    featured_products = [
      %{
        id: 101,
        # Комплект ремонту - високий чек
        name: "Renault PK6 Rebuild Kit",
        price: 4500,
        currency: "UAH",
        image: "/images/p/pk6_kit.jpg",
        badges: ["Bestseller", "Renault Trafic"]
      },
      %{
        id: 102,
        # Розхідник - часто купують
        name: "Elf Tranself NFP 75W-80 (1L)",
        price: 600,
        currency: "UAH",
        image: "/images/p/oil.jpg",
        badges: ["OEM Choice"]
      },
      %{
        id: 103,
        # Агрегат - дуже високий чек
        name: "Gearbox PF6 (Exchange)",
        price: 25000,
        currency: "UAH",
        image: "/images/p/pf6_gearbox.jpg",
        badges: ["Warranty 1 Year"]
      }
    ]

    socket =
      socket
      |> assign(:page_title, "Запчастини КПП Renault | 5peredacha")
      |> assign(:categories_tree, categories_tree)
      |> assign(:featured_products, featured_products)
      |> assign(:hero_slides, get_shop_hero_slides())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="shop-container bg-gray-50 font-sans">
      <% # 1. HERO SECTION WITH CAR SELECTOR %>
      <% # Важливо: Фон має бути темним або з зображенням механіки, щоб виділити віджет пошуку %>
      <div class="relative bg-gray-900 text-white overflow-hidden">
        <div class="absolute inset-0 opacity-40">
          <img src="/images/hero/workshop_bg.jpg" class="w-full h-full object-cover" alt="Workshop" />
        </div>

        <div class="relative max-w-7xl mx-auto px-4 py-16 sm:px-6 lg:px-8 flex flex-col md:flex-row items-center gap-12">
          <div class="md:w-1/2 space-y-6">
            <h1 class="text-4xl md:text-5xl font-extrabold tracking-tight">
              Ваша трансмісія — <span class="text-yellow-400">наша турбота</span>
            </h1>
            <p class="text-xl text-gray-300">
              Спеціалізований магазин запчастин для КПП Renault (Trafic, Master, Kangoo). Від сальника до нової коробки.
            </p>

            <% # Trust Signals right in Hero %>
            <div class="flex gap-4 text-sm text-gray-300 pt-4">
              <span class="flex items-center gap-2">✅ Тільки оригінал та перевірені аналоги</span>
              <span class="flex items-center gap-2">🔧 Власне СТО</span>
            </div>
          </div>

          <% # THE WIDGET: Найважливіша частина для автомагазину %>
          <div class="md:w-1/2 w-full bg-white rounded-xl shadow-2xl p-6 text-gray-900">
            <h3 class="text-lg font-bold mb-4 flex items-center gap-2">
              🚗 Підберіть запчастини до вашого авто
            </h3>
            <.live_component module={VehicleSelector} id="hero-selector" />
          </div>
        </div>
      </div>

      <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 space-y-20">
        <% # 2. CATEGORY TREE: Розбивка по секціях %>
        <%= for section <- @categories_tree do %>
          <section>
            <div class="flex items-end justify-between mb-6 border-b border-gray-200 pb-2">
              <div>
                <h2 class="text-2xl font-bold text-gray-900">{section.title}</h2>
                <p class="text-sm text-gray-500">{section.description}</p>
              </div>
              <.link
                href={~p"/shop/c/#{section.slug}"}
                class="text-blue-600 hover:text-blue-800 font-medium text-sm"
              >
                Дивитись всі &rarr;
              </.link>
            </div>

            <% # Grid адаптований під різні типи товарів (менші картки для дрібниць) %>
            <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 gap-4">
              <%= for item <- section.items do %>
                <.link
                  navigate={item.url}
                  class="group bg-white rounded-lg shadow-sm hover:shadow-md transition border border-gray-100 overflow-hidden flex flex-col"
                >
                  <div class="aspect-w-16 aspect-h-10 bg-gray-100 relative">
                    <%!-- <img src={item.image} alt={item.name} class="object-cover w-full h-full group-hover:scale-105 transition duration-300"> --%>
                  </div>
                  <div class="p-3 text-center">
                    <span class="text-sm font-semibold text-gray-800 group-hover:text-blue-600">
                      {item.name}
                    </span>
                  </div>
                </.link>
              <% end %>
            </div>
          </section>
        <% end %>

        <% # 3. PROMO STRIP: Більш деталізовані переваги %>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 bg-blue-50 rounded-2xl p-8 border border-blue-100">
          <div class="flex items-start gap-4">
            <div class="p-3 bg-blue-600 rounded-lg text-white">📦</div>
            <div>
              <h4 class="font-bold text-gray-900">Відправка в день замовлення</h4>
              <p class="text-sm text-gray-600">При замовленні до 15:00. Працюємо з Новою Поштою.</p>
            </div>
          </div>
          <div class="flex items-start gap-4">
            <div class="p-3 bg-blue-600 rounded-lg text-white">🛡️</div>
            <div>
              <h4 class="font-bold text-gray-900">Гарантія на агрегати</h4>
              <p class="text-sm text-gray-600">
                До 12 місяців гарантії на відновлені КПП та двигуни.
              </p>
            </div>
          </div>
          <div class="flex items-start gap-4">
            <div class="p-3 bg-blue-600 rounded-lg text-white">👨‍🔧</div>
            <div>
              <h4 class="font-bold text-gray-900">Допомога механіка</h4>
              <p class="text-sm text-gray-600">
                Не впевнені? Наш майстер перевірить сумісність по VIN.
              </p>
            </div>
          </div>
        </div>

        <% # 4. FEATURED PRODUCTS (TABBED) %>
        <section>
          <div class="flex flex-col sm:flex-row justify-between items-center mb-8">
            <h2 class="text-2xl font-bold text-gray-900">Популярні товари</h2>

            <% # Tabs for filtering featured items without reloading %>
            <div class="flex space-x-2 bg-gray-100 p-1 rounded-lg mt-4 sm:mt-0">
              <button class="px-4 py-1 bg-white shadow-sm rounded-md text-sm font-medium text-gray-900">
                Хіти продажів
              </button>
              <button class="px-4 py-1 hover:bg-gray-200 rounded-md text-sm font-medium text-gray-500">
                Акції
              </button>
              <button class="px-4 py-1 hover:bg-gray-200 rounded-md text-sm font-medium text-gray-500">
                Рекомендуємо
              </button>
            </div>
          </div>

          <.live_component module={FeaturedProducts} id="featured-list" products={@featured_products} />
        </section>

        <% # 5. SEO & EXPERTISE BLOCK %>
        <section class="prose prose-blue max-w-none text-gray-600 bg-white p-8 rounded-xl shadow-sm border border-gray-100">
          <h3>Чому варто купувати запчастини КПП у нас?</h3>
          <p>
            Ми не просто інтернет-магазин, ми — спеціалізований сервіс. У нас ви знайдете як <strong>оригінальні запчастини Renault</strong>, так і якісні аналоги від брендів SNR, Corteco, Euroricambi.
          </p>
          <div class="grid md:grid-cols-2 gap-8 not-prose mt-6">
            <ul class="space-y-2">
              <li class="flex items-center text-sm">🔹 Власний склад запчастин для PK5, PK6, PF6</li>
              <li class="flex items-center text-sm">🔹 Обмінний фонд КПП (Trade-in)</li>
            </ul>
            <ul class="space-y-2">
              <li class="flex items-center text-sm">🔹 Професійний підбір підшипників за розмірами</li>
              <li class="flex items-center text-sm">🔹 Спеціальні ціни для СТО</li>
            </ul>
          </div>
        </section>
      </main>
    </div>
    """
  end

  defp get_shop_hero_slides() do
    # Слайдер залишаємо для акцій, але він стає другорядним порівняно з пошуком авто
    [
      %{
        image: "/images/hero/sale.jpg",
        title: "Spring Sale: 20% Off All Bearings",
        subtitle: "Keep your gearbox running smoothly",
        alt: "Transmission Parts Sale"
      }
    ]
  end
end
