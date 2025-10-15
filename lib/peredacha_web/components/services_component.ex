defmodule PeredachaWeb.Components.ServicesComponent do
  use PeredachaWeb, :live_component

  @services [
    %{
      id: 1,
      icon: "diagnostic",
      title: "Діагностика та дефектування КПП",
      description:
        "Проводимо повну діагностику МКПП на спеціалізованому обладнанні, точно виявляючи причини несправностей."
    },
    %{
      id: 2,
      icon: "repair",
      title: "Ремонт МКПП та заміна зчеплення",
      description:
        "Виконуємо якісний ремонт, замінюючи зношені деталі: підшипники, синхронізатори, шестерні. Професійно проводимо заміну комплекту зчеплення."
    },
    %{
      id: 3,
      icon: "store",
      title: "Продаж комплектуючих та аксесуарів Renault",
      description:
        "Пропонуємо асортимент нових та вживаних коробок передач, а також оригінальних запчастин. Допоможемо підібрати найкращий варіант для вашого авто."
    },
    %{
      id: 4,
      icon: "oil",
      title: "Заміна мастила в КПП та АКПП",
      description:
        "Виконуємо заміну мастила у коробках передач з дотриманням усіх технічних вимог виробника."
    },
    %{
      id: 5,
      icon: "welding",
      title: "Аргонне зварювання",
      description:
        "Відновлюємо пошкоджені корпуси коробок передач за допомогою аргонного зварювання, що дозволяє уникнути дорогої заміни."
    }
  ]

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns) |> assign(:services, @services)}
  end

  defp service_card(assigns) do
    assigns = assign_new(assigns, :class, fn -> "" end)

    ~H"""
    <div class={@class}>
      <div class="
        flex h-full flex-col overflow-hidden rounded-2xl
        border border-base-content/10 bg-base-200
        shadow-lg transition-all duration-300 ease-in-out
        hover:-translate-y-2 hover:shadow-xl hover:shadow-primary/20
      ">
        <div class="flex-shrink-0">
          <img
            src={PeredachaWeb.Endpoint.static_path("/images/services/#{@service.icon}.png")}
            alt={@service.title}
            class="h-56 w-full object-cover"
          />
        </div>
        <div class="flex flex-grow flex-col justify-between p-6">
          <div>
            <h3 class="mb-3 text-xl font-bold text-base-content">
              {@service.title}
            </h3>
            <p class="leading-relaxed text-base-content/70">
              {@service.description}
            </p>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id="services" class="container scroll-mt-24 mx-auto px-4">
      <div class="relative -mx-4 md:mx-0">
        <div class="hero min-h-[50vh] bg-base-200 rounded-none md:rounded-2xl p-6 sm:p-10">
          <div class="w-full">
            <!-- Заголовок блоку -->
            <div class="mx-auto mb-12 max-w-3xl text-center px-2 md:px-0">
              <h2 class="mb-4 text-4xl font-bold tracking-tight md:text-5xl">
                Наші Послуги
              </h2>
              <p class="text-lg text-base-content/80">
                Ми пропонуємо повний спектр професійних послуг з ремонту та обслуговування механічних коробок передач.
              </p>
            </div>

            <!-- Desktop Grid -->
            <div class="hidden md:grid grid-cols-1 gap-8 md:grid-cols-2 lg:grid-cols-4">
              <%= for service <- @services do %>
                <.service_card service={service} />
              <% end %>
            </div>

            <!-- Mobile Carousel -->
            <div class="md:hidden mt-6">
              <div class="w-screen relative left-1/2 right-1/2 -mx-[50vw] flex items-stretch snap-x snap-mandatory gap-5 overflow-x-auto pb-6 px-5 scrollbar-none scroll-smooth">
                <%= for service <- @services do %>
                  <div class="flex-shrink-0 snap-center basis-[85%] max-w-[85vw] flex">
                    <.service_card
                      service={service}
                      class="flex-1 card bg-base-100 shadow-xl border border-base-300 hover:shadow-2xl transition-all duration-300 ease-in-out"
                    />
                  </div>
                <% end %>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
