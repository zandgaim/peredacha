defmodule PeredachaWeb.Components.MapComponent do
  use PeredachaWeb, :live_component

  def render(assigns) do
    ~H"""
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
    """
  end
end
