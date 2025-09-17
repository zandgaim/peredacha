defmodule PeredachaWeb.DescriptionComponent do
  use PeredachaWeb, :live_component

  def render(assigns) do
    ~H"""
    <section class="py-20 bg-slate-50">
      <div class="container mx-auto px-4">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center mb-24">
          <div class="order-2 lg:order-1">
            <h2 class="text-4xl font-bold text-gray-800 mb-4">
              «5 передача» — експерти з ремонту КПП Renault
            </h2>

            <p class="text-lg text-gray-600 mb-6 leading-relaxed">
              Ми спеціалізуємося на ремонті механізованих та роботизованих коробок передач для комерційних автомобілів Renault. Забезпечуємо точний підхід, сучасне обладнання та швидке виконання робіт. Більшість ремонтів ми виконуємо менш ніж за половину робочого дня.
            </p>

            <div class="space-y-4">
              <div class="flex items-start">
                <%!-- <%!-- Heroicon: shield-check --%>
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-6 w-6 text-blue-500 mr-3 mt-1 flex-shrink-0"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
                  />
                </svg>
                <p class="text-lg">
                  <strong>Гарантія 3–6 місяців</strong> на всі роботи та комплектуючі.
                </p>
              </div>

              <div class="flex items-start">
                <%!-- Heroicon: badge-check --%>
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-6 w-6 text-blue-500 mr-3 mt-1 flex-shrink-0"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"
                  />
                </svg>
                <p class="text-lg">
                  <strong>15+ років досвіду</strong> у щоденному ремонті КПП Renault.
                </p>
              </div>

              <div class="flex items-start">
                <%!-- Heroicon: clock --%>
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-6 w-6 text-blue-500 mr-3 mt-1 flex-shrink-0"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                  stroke-width="2"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                  />
                </svg>
                <p class="text-lg">
                  <strong>Швидке виконання</strong>
                  — якщо деталі є в наявності, ремонт триває до одного робочого дня.
                </p>
              </div>
            </div>
          </div>

          <div class="order-1 lg:order-2">
            <img
              src={PeredachaWeb.Endpoint.static_path("/images/steps/step_1.png")}
              alt="Ремонт КПП Renault"
              class="rounded-lg shadow-xl"
            />
          </div>
        </div>

        <div class="text-center">
          <h2 class="text-4xl font-bold text-gray-800 mb-4">Як це працює</h2>

          <p class="text-lg text-gray-600 max-w-2xl mx-auto mb-12">
            Наш процес простий, прозорий і розроблений, щоб повернути вас на дорогу якомога швидше.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8 text-center">
          <%!-- <div class="card bg-base-100 shadow-lg p-8">
            <div class="mb-4">
              <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-blue-100 text-blue-500 font-bold text-xl">
                1
              </span>
            </div>

            <h3 class="text-xl font-bold mb-2">Попередня діагностика</h3>

            <p>Ви телефонуєте нам, ми проводимо первинну діагностику та записуємо авто на візит.</p>
          </div> --%>

          <div class="card bg-base-100 image-full w-80 shadow-lg mx-auto">
            <figure>
              <img
                src={PeredachaWeb.Endpoint.static_path("/images/steps/step_11.png")}
                alt="Дзвінок або заявка"
              />
            </figure>
            <div class="card-body text-center">
              <h2 class="card-title text-yellow-500">1. Дзвінок або заявка</h2>
              <p class="text-gray-600">
                Ви телефонуєте нам або залишаєте заявку на сайті, і ми зв'язуємося з Вами.
              </p>
            </div>
          </div>

          <div class="card bg-base-100 shadow-lg p-8">
            <div class="mb-4">
              <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-blue-100 text-blue-500 font-bold text-xl">
                2
              </span>
            </div>

            <h3 class="text-xl font-bold mb-2">Детальна перевірка та ремонт</h3>

            <p>
              Під час візиту визначаємо стан КПП, пропонуємо варіанти ремонту та виконуємо роботи.
            </p>
          </div>

          <div class="card bg-base-100 shadow-lg p-8">
            <div class="mb-4">
              <span class="inline-flex items-center justify-center h-12 w-12 rounded-full bg-blue-100 text-blue-500 font-bold text-xl">
                3
              </span>
            </div>

            <h3 class="text-xl font-bold mb-2">Фінальне тестування</h3>

            <p>
              Після ремонту КПП проходить контрольну перевірку, і ви отримуєте авто у справному стані.
            </p>
          </div>
        </div>
      </div>
    </section>
    """
  end
end
