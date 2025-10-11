defmodule PeredachaWeb.DescriptionComponent do
  use PeredachaWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="bg-base-100">
      <div class="container mx-auto px-4 py-16 md:py-24 space-y-24">
        <%!-- About Us Section using Hero Component --%>
        <div class="hero min-h-[50vh] bg-base-200 rounded-2xl p-4 sm:p-8">
          <div class="hero-content flex-col lg:flex-row-reverse gap-12">
            <img
              src={PeredachaWeb.Endpoint.static_path("/images/steps/step_1.png")}
              class="w-full max-w-md rounded-lg shadow-2xl lg:w-1/2 lg:max-w-none"
              alt="Ремонт КПП Renault"
            />
            <div class="text-center lg:text-left lg:w-1/2">
              <h1 class="text-4xl md:text-5xl font-bold">
                «5 передача» — експерти з ремонту КПП Renault
              </h1>

              <p class="py-6 text-lg">
                Ми спеціалізуємося на ремонті механізованих та роботизованих коробок передач для комерційних автомобілів Renault. Забезпечуємо точний підхід, сучасне обладнання та швидке виконання робіт. Більшість ремонтів ми виконуємо менш ніж за половину робочого дня.
              </p>

              <div class="space-y-4 max-w-md mx-auto lg:mx-0">
                <div class="flex items-start p-3 bg-base-100/80 rounded-lg">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-6 w-6 text-primary mr-3 mt-0.5 flex-shrink-0"
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
                  <span><strong>Гарантія 3–6 місяців</strong> на всі роботи та комплектуючі.</span>
                </div>

                <div class="flex items-start p-3 bg-base-100/80 rounded-lg">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-6 w-6 text-primary mr-3 mt-0.5 flex-shrink-0"
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
                  <span><strong>15+ років досвіду</strong> у щоденному ремонті КПП Renault.</span>
                </div>

                <div class="flex items-start p-3 bg-base-100/80 rounded-lg">
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-6 w-6 text-primary mr-3 mt-0.5 flex-shrink-0"
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

                  <span>
                    <strong>Швидке виконання</strong>
                    — ремонт до одного робочого дня за наявності деталей.
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <%!-- How It Works Section using Cards and Steps --%>
        <div class="text-center">
          <h2 class="text-4xl md:text-5xl font-bold mb-4">Як це працює?</h2>

          <p class="text-lg max-w-2xl mx-auto text-base-content/80">
            Наш процес простий, прозорий і розроблений, щоб повернути вас на дорогу якомога швидше.
          </p>
        </div>
        <%!-- On Desktop: Show Cards. On Mobile: Show Steps --%> <%!-- Hide cards on mobile --%>
        <div class="hidden md:grid grid-cols-1 md:grid-cols-3 gap-6 lg:gap-8">
          <div class="card bg-base-200 shadow-xl text-center">
            <div class="card-body items-center">
              <div class="badge badge-primary badge-lg text-2xl font-bold p-4 mb-4">1</div>

              <h3 class="card-title text-2xl font-bold">Дзвінок або заявка</h3>

              <p>Ви телефонуєте нам або залишаєте заявку на сайті, і ми зв'язуємося з Вами.</p>
            </div>
          </div>

          <div class="card bg-base-200 shadow-xl text-center">
            <div class="card-body items-center">
              <div class="badge badge-primary badge-lg text-2xl font-bold p-4 mb-4">2</div>

              <h3 class="card-title text-2xl font-bold">Перевірка та ремонт</h3>

              <p>Визначаємо стан КПП, пропонуємо варіанти ремонту та якісно виконуємо роботи.</p>
            </div>
          </div>

          <div class="card bg-base-200 shadow-xl text-center">
            <div class="card-body items-center">
              <div class="badge badge-primary badge-lg text-2xl font-bold p-4 mb-4">3</div>

              <h3 class="card-title text-2xl font-bold">Тестування та гарантія</h3>

              <p>
                Після ремонту КПП проходить контрольну перевірку, і ви отримуєте авто у справному стані.
              </p>
            </div>
          </div>
        </div>
        <%!-- Hide steps on desktop --%>
        <ul class="steps steps-vertical md:hidden">
          <li class="step step-primary">
            <div class="text-left p-4">
              <h3 class="font-bold text-lg">Дзвінок або заявка</h3>

              <p class="text-sm text-base-content/70">
                Ви телефонуєте нам або залишаєте заявку на сайті, і ми зв'язуємося з Вами.
              </p>
            </div>
          </li>

          <li class="step step-primary">
            <div class="text-left p-4">
              <h3 class="font-bold text-lg">Перевірка та ремонт</h3>

              <p class="text-sm text-base-content/70">
                Визначаємо стан КПП, пропонуємо варіанти ремонту та якісно виконуємо роботи.
              </p>
            </div>
          </li>

          <li class="step">
            <div class="text-left p-4">
              <h3 class="font-bold text-lg">Тестування та гарантія</h3>

              <p class="text-sm text-base-content/70">
                Після ремонту КПП проходить контрольну перевірку, і ви отримуєте авто у справному стані.
              </p>
            </div>
          </li>
        </ul>
      </div>
    </div>
    """
  end
end
