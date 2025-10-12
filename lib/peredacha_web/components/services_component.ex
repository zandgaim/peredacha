defmodule PeredachaWeb.Components.ServicesComponent do
  use PeredachaWeb, :live_component

  @services [
    %{
      id: 1,
      icon: :diagnostic,
      title: "Діагностика та дефектування КПП",
      description:
        "Проводимо повну діагностику МКПП на спеціалізованому обладнанні, точно виявляючи причини несправностей, такі як шум, вібрація чи утруднене перемикання передач."
    },
    %{
      id: 2,
      icon: :repair,
      title: "Ремонт МКПП та заміна зчеплення",
      description:
        "Виконуємо якісний ремонт, замінюючи зношені деталі: підшипники, синхронізатори, шестерні. Професійно проводимо заміну комплекту зчеплення."
    },
    %{
      id: 3,
      icon: :store,
      title: "Продаж КПП та запчастин",
      description:
        "Пропонуємо асортимент нових та вживаних коробок передач, а також оригінальних запчастин. Допоможемо підібрати найкращий варіант для вашого авто."
    },
    %{
      id: 4,
      icon: :welding,
      title: "Аргонне зварювання",
      description:
        "Відновлюємо пошкоджені корпуси коробок передач за допомогою аргонного зварювання, що дозволяє уникнути дорогої заміни та продовжити термін служби агрегату."
    }
  ]

  @impl true
  def update(assigns, socket) do
    {:ok, assign(socket, assigns) |> assign(:services, @services)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section id="services" class="bg-gray-900 text-white py-16 md:py-24">
      <div class="container mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-16">
          <h2 class="text-4xl sm:text-5xl font-extrabold tracking-tight text-white">
            Наші послуги
          </h2>
          <p class="mt-4 mx-auto max-w-3xl text-xl text-gray-400">
            Професійний підхід до ремонту вашої трансмісії
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          <%= for service <- @services do %>
            <div class="
              bg-[#1E293B]  /* Custom dark blue/gray background for cards */
              rounded-xl
              overflow-hidden
              shadow-2xl
              shadow-gray-900/50 /* Darker, more pronounced shadow */
              border border-transparent
              hover:border-primary /* Subtle border on hover */
              transform
              hover:-translate-y-1 /* Lighter lift effect */
              transition
              duration-300
              ease-in-out
              flex flex-col /* Make content stretch to full height */
            ">
              <div class="flex-shrink-0">
                <img
                  src={PeredachaWeb.Endpoint.static_path("/images/service/#{service.icon}.png")}
                  alt={service.title}
                  class="w-full h-48 object-cover md:h-56"
                />
              </div>

              <div class="p-6 flex-grow flex flex-col justify-between">
                <h3 class="text-2xl font-semibold mb-3 text-white">
                  {service.title}
                </h3>
                <p class="text-gray-400 text-base leading-relaxed">
                  {service.description}
                </p>
              </div>
            </div>
          <% end %>
        </div>
      </div>
    </section>
    """
  end
end
