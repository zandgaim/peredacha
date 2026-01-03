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
                class="btn btn-primary btn-lg w-full shadow-lg shadow-primary/20 normal-case flex items-center justify-center gap-3"
              >
                <svg
                  class="h-6 w-6 fill-current"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 100 100"
                >
                  <path
                    d="M83.117 0c-6.88 0-12.698 4.735-14.379 11.092l-1.851-.86a2.5 2.5 0 0 0-2.108 0L34.166 24.453L3.553 10.233A2.5 2.5 0 0 0 0 12.5v70.287a2.5 2.5 0 0 0 1.447 2.268l31.666 14.709a2.5 2.5 0 0 0 2.108 0l30.613-14.22l30.613 14.22c1.657.769 3.553-.44 3.553-2.266V27.211a2.5 2.5 0 0 0-1.447-2.268l-3.23-1.502l1.011-1.722c.23-.417.413-.861.57-1.315A14.645 14.645 0 0 0 98 14.842C98 6.685 91.298 0 83.117 0zm0 6.953c4.405 0 7.908 3.496 7.908 7.889c0 4.392-3.503 7.885-7.908 7.885s-7.908-3.493-7.908-7.885c0-4.393 3.503-7.889 7.908-7.889zm-16.166 8.822l1.377.641a14.726 14.726 0 0 0 2.625 6.938l10.348 17.89c1.45 1.894 2.414 1.534 3.619-.1l7.857-13.373L95 28.805V93.58L67.322 80.723l-.226-39.676c.408.088.815.173 1.224.27l.92-3.891a63.862 63.862 0 0 0-2.168-.473l-.12-21.178zm-2.998.354l.115 20.336a33.73 33.73 0 0 0-3.113-.281l-.148 3.996c1.088.04 2.185.158 3.285.318l.23 40.234l-28.676 13.323l-.369-64.604L63.953 16.13zM5 16.418l27.275 12.67l.371 64.947L5 81.191V16.418zm51.543 20.039c-1.377.247-2.786.688-4.098 1.451a9.932 9.932 0 0 0-3.732 3.82l3.502 1.932a6.003 6.003 0 0 1 2.226-2.289l.006-.004l.006-.004c.807-.47 1.768-.786 2.797-.97l-.707-3.936zm16.666 2.031l-1.133 3.834c2.503.74 4.982 1.59 7.447 2.51l1.399-3.748c-2.532-.944-5.1-1.824-7.713-2.596zm-26.002 7.596l-.03.158l-.003.014c-.499 2.831-.446 5.617-.334 8.265l3.996-.17c-.109-2.569-.132-5.055.277-7.388l.024-.125l-3.93-.754zm3.867 12.21l-3.99.27c.18 2.669.372 5.285.365 7.85l4 .01c.008-2.77-.195-5.478-.375-8.13zm-3.824 11.89c-.11.953-.274 1.88-.514 2.77l-.002.005l-.002.008c-.35 1.335-.939 2.571-1.761 3.539l3.047 2.59c1.288-1.515 2.105-3.298 2.58-5.102l.002-.006c.3-1.116.495-2.24.623-3.35l-3.973-.454zm-33.768 3.898l-1.796 3.574c2.48 1.247 5.045 2.278 7.628 3.17l1.305-3.781c-2.455-.847-4.852-1.815-7.137-2.963zm10.836 4.113l-1.064 3.856c2.646.731 5.366 1.312 8.146 1.625l.446-3.975c-2.521-.283-5.035-.817-7.528-1.506zm18.141.282c-1.992 1.02-4.397 1.397-6.87 1.427l.05 4c2.834-.034 5.864-.444 8.642-1.867l-1.822-3.56z"
                    fill-rule="evenodd"
                  >
                  </path>
                </svg>
                <span>{gettext("Прокласти маршрут")}</span>
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
