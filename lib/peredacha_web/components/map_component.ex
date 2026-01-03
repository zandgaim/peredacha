defmodule PeredachaWeb.Components.MapComponent do
  use PeredachaWeb, :live_component

  def render(assigns) do
    ~H"""
    <section id="contacts" class="py-20 bg-base-200/50">
      <div class="container mx-auto px-4 max-w-6xl">
        <div class="text-center mb-12">
          <h2 class="text-4xl md:text-5xl font-extrabold mt-2 mb-4 tracking-tight">
            {gettext("Ми на карті")}
          </h2>
          <p class="text-base-content/60 text-lg max-w-2xl mx-auto">
            {gettext("Завітайте до нашого сервісу — зручно розташовані у самому центрі Дрогобича")}
          </p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 bg-base-100 rounded-3xl overflow-hidden shadow-2xl border border-base-content/5">
          <%!-- Info Sidebar --%>
          <div class="p-8 md:p-12 flex flex-col justify-between bg-base-100 order-2 lg:order-1">
            <div class="space-y-8">
              <div>
                <h3 class="text-2xl font-bold mb-6 flex items-center gap-2">
                  <div class="w-2 h-8 bg-primary rounded-full"></div>
                  {gettext("Контактна інформація")}
                </h3>

                <div class="space-y-6">
                  <div class="flex gap-4">
                    <div class="p-3 bg-primary/10 text-primary rounded-xl h-fit">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-6 w-6"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"
                        />
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"
                        />
                      </svg>
                    </div>
                    <div>
                      <p class="font-bold text-lg">{gettext("Адреса")}</p>
                      <p class="text-base-content/70">
                        {gettext("вул. Стрийська, 123")}<br />
                        {gettext("м. Дрогобич, 82100")}
                      </p>
                    </div>
                  </div>

                  <div class="flex gap-4">
                    <div class="p-3 bg-secondary/10 text-secondary rounded-xl h-fit">
                      <svg
                        xmlns="http://www.w3.org/2000/svg"
                        class="h-6 w-6"
                        fill="none"
                        viewBox="0 0 24 24"
                        stroke="currentColor"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                        />
                      </svg>
                    </div>
                    <div>
                      <p class="font-bold text-lg">{gettext("Графік роботи")}</p>
                      <div class="text-base-content/70 text-sm">
                        <div class="flex justify-between gap-4">
                          <span>{gettext("Пн-Пт:")}</span> <span>09:00 - 18:00</span>
                        </div>
                        <div class="flex justify-between gap-4">
                          <span>{gettext("Сб:")}</span> <span>10:00 - 15:00</span>
                        </div>
                        <div class="flex justify-between gap-4 text-error">
                          <span>{gettext("Нд:")}</span> <span>{gettext("Вихідний")}</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="mt-10 lg:mt-0">
              <a
                href="https://www.google.com/maps/dir/?api=1&destination=вул+Стрийська+123+Дрогобич"
                target="_blank"
                class="btn btn-primary btn-lg w-full shadow-lg shadow-primary/20 normal-case"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-5 w-5"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M9 20l-5.447-2.724A2 2 0 013 15.382V6.418a2 2 0 011.106-1.789L9 2l6 3 5.447-2.724A2 2 0 0123 4.618v8.962a2 2 0 01-1.106 1.789L15 18l-6 2z"
                  />
                </svg>
                {gettext("Прокласти маршрут")}
              </a>
            </div>
          </div>

          <%!-- Map Area --%>
          <div class="lg:col-span-2 h-[400px] lg:h-full min-h-[450px] order-1 lg:order-2 relative">
            <%!-- Optional: Decorative overlay for better blending --%>
            <div class="absolute inset-0 pointer-events-none ring-1 ring-inset ring-black/5"></div>
            <iframe
              src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2599.785599426572!2d23.5112053!3d49.337277799999995!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x473a4fef51b86661%3A0xffa166c878faa48c!2zNSDQn9C10YDQtdC00LDRh9CwINCh0LXRgNCy0ZbRgSBSZW5hdWx0!5e0!3m2!1sru!2spl!4v1760475572653!5m2!1sru!2spl"
              width="100%"
              height="100%"
              style="border:0; filter: grayscale(0.2) contrast(1.1);"
              allowfullscreen=""
              loading="lazy"
              referrerpolicy="no-referrer-when-downgrade"
              class="w-full h-full block"
            >
            </iframe>
          </div>
        </div>
      </div>
    </section>
    """
  end
end
